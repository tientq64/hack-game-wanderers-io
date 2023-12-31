require! {
   "puppeteer-core": puppeteer
   chalk
}

browserNum = 4
headless = yes
defaultTimeout = 30000

logs = Array browserNum .fill!map (, i) ~>
   "#i -"

setLog = (i, j, text) !->
   j ?= \-
   text ?= ""
   logs[i] = "#i #j #text"
   console.clear!
   for log, k in logs
      if i is k
         if text
            console.log chalk.red log
         else
            console.log chalk.green log
      else
         console.log log

blockUrls =
   \https://spritestack.io/promo
   \https://www.google-analytics.com
   \https://www.googletagmanager.com
   \https://syndication.twitter.com
   \https://platform.twitter.com
   \https://wanderers.io/client/server/EU/Sandbox/undefined
   \https://wanderers.io/style/menu.gif
   \https://wanderers.io/fonts
   \https://wanderers.io/sounds
   \https://stats.g.doubleclick.net

await Promise.all Array.from (Array browserNum), (, i) !~>
   browser = await puppeteer.launch do
      headless: headless
      executablePath: "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
      userDataDir: "F:/puppeteer-user-data-dir"
      args: [
         "--window-size=870,730"
      ]

   page = (await browser.pages!)0
   page.setDefaultTimeout defaultTimeout
   await page.setRequestInterception yes
   page.on \request (req) !~>
      url = req.url!
      for blockUrl in blockUrls
         if blockUrl.endsWith \$
            blockUrl .= slice 0 -1
            matched = url.endsWith blockUrl
         else
            matched = url.includes blockUrl
         if matched
            req.abort!
            return
      req.continue!
   loop
      try
         await page.goto \https://wanderers.io,
            waitUntil: \networkidle0
         break
      catch
         setLog i,, "Goto timeout"

   len = 100
   for j til len
      try
         await page.click ".showMainMenu"
         await page.click ".modePicker > .ui-tabs > :nth-child(2)"
         await page.waitForFunction ~>
            # name = Math.random!toString 36 .replace \. ""
            name = "BUILDER"
            document.querySelector \.tribeName .value = name
            document.querySelector \.groupName .value = ""
            CLIENT.Game.server_url = \s14523994187
            yes
         await page.click ".start"
         await page.waitForFunction "CLIENT.Game.player"
         setLog i, j
         await page.evaluate (i, j) !~>
            {Game} = CLIENT
            Game.camera.setFollow Game.player
            wait = (ms) ~>
               new Promise (resolve) !~>
                  setTimeout resolve, ms
            getDistanceXYToPlayer = (x, y) ~>
               Math.hypot Game.player.x - x, Game.player.y - y
            moveToXY = (x, y) !~>
               distance = getDistanceXYToPlayer x, y
               Game.send \move {x, y}
               await wait distance * 15
            king = Game.entities.groups.tribes.find (.shared.name == \Hotandsour)
            # if !king
            #    return
            # if king.team != Game.player.team
            #    for member in Game.player.members
            #       Game.send \stay,
            #          target: member.sid
            #    return
            # await moveToXY king.x, king.y
            {x, y} = king
            # if Game.player.team != 0
            #    for member in Game.player.members
            #       Game.send \stay,
            #          target: member.sid
            #    return
            # x = 624
            # y = 666
            rx = Math.round x + Utils.random -500 500
            ry = Math.round y + Utils.random -500 500
            # await moveToXY mx, my
            n = 100
            while Game.playerData.resources.wood >= 2 and !Game.player._remove and n
               Game.send \buildAnywhere,
                  x: rx
                  y: ry
                  key: \stationary_catapult
               n--
            for member in Game.player.members
               Game.send \stay,
                  target: member.sid
         , i, j
         await page.waitForTimeout 1000

      catch
         setLog i, j, e.message

      unless j == len - 1
         loop
            try
               await page.reload do
                  waitUntil: \networkidle0
               break
            catch
               setLog i, j, "Reload timeout"

   await page.close!
   await browser.close!

process.exit!
