require! {
   "puppeteer-core": puppeteer
   "chalk"
}

browserNum = 4
headless = yes
defaultTimeout = 10000

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
   await new Promise (resolve) !~>
      setTimeout resolve, i * 5000

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
         index = url.search blockUrl
         if index >= 0
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

   for j til 100
      try
         await page.click \.showMainMenu
         await page.click ".modePicker > .ui-tabs > :nth-child(2)"
         await page.waitForFunction ~>
            document.querySelector \.tribeName .value = "Hanoi2"
            document.querySelector \.groupName .value = "Hanoi2"
            CLIENT.Game.server_url = \s14421783116
            yes
         await page.click \.start
         await page.waitForFunction \CLIENT.Game.player
         setLog i, j

         await page.evaluate !~>
            {Game} = CLIENT
            Game.camera.setFollow Game.player
            Game.music.channel.volume 0

            countdown = 100
            while countdown--
               sx = Utils.random 0 48
               sy = Utils.random 3 78
               ex = sx
               ey = sy
               if Utils.random 0 1
                  ex += 2
               else
                  ey += 2
               if Game.walls.canConnect sx, sy, ex, ey
                  Game.send \buildWall {sx, sy, ex, ey}
                  break

            # for member in Game.player.members
            #    Game.send \stay,
            #       target: member.sid

            # centerGx = 24
            # centerGy = 36
            # extend = 0
            # :build loop
            #   for sx from centerGx - extend to centerGx + extend by 4
            #     sy = centerGy - extend
            #     ex = sx + 2
            #     ey = sy
            #     if Game.walls.canConnect sx, sy, ex, ey
            #       Game.send \buildWall {sx, sy, ex, ey}
            #       break build
            #   extend += 2
            #   if extend > 20
            #     break

         await page.waitForTimeout 1000

      catch
         setLog i, j, e.message

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
