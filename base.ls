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
            document.querySelector \.groupName .value = "123"
            CLIENT.Game.server_url = \s14421783116
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
            # kingNames = <[Vietnam]>
            # kingName = kingNames[Utils.random 0 kingNames.length - 1]
            # king = Game.entities.groups.tribes.find (.shared.name == kingName)
            # if !king
            #    return
            # if king.team != Game.player.team
            #    for member in Game.player.members
            #       Game.send \stay,
            #          target: member.sid
            #    return
            # await moveToXY king.x, king.y
            # {x, y} = king
            # if Game.player.team != 0
            #    for member in Game.player.members
            #       Game.send \stay,
            #          target: member.sid
            #    return
            x = 1000
            y = 1000
            gx = Math.round x / COMMON.GRID_WIDTH
            gy = Math.round y / COMMON.GRID_HEIGHT
            # if king.team != Game.player.team
            #    gx--
            #    gy--
            x = gx * COMMON.GRID_WIDTH
            y = gy * COMMON.GRID_HEIGHT
            findBuilding = (gx, gy, keys) ~>
               unless Array.isArray keys
                  keys = [keys]
               spriteNames = keys.map (\building/ +)
               Game.entities.groups.buildings.find (building) ~>
                  building.gx == gx and building.gy == gy and spriteNames.includes building.spriteName
            buildWall = (sx, sy, ew, eh) !~>
               ex = sx + ew
               ey = sy + eh
               unless findBuilding sx, sy, \stone_node and findBuilding ex, ey, \stone_node and !Game.walls.canConnect sx, sy, ex, ey
                  Game.send \buildWall {sx, sy, ex, ey}
            buildTower = (gx, gy) !~>
               unless findBuilding gx, gy, \stone_tower
                  node = findBuilding gx, gy, \stone_node
                  if node
                     Game.send \buildOnNode,
                        key: \stone_tower
                        node_sid: node.sid
            # mod = void
            mod = i % 4
            gr = 18
            # gr = 1 if king.team != Game.player.team
            gr = gr * 2 - 1
            for k from -gr til gr by 2
               if mod == void
                  buildWall gx + k, gy - gr, 2 0
                  buildWall gx + k, gy + gr, 2 0
                  buildWall gx - gr, gy + k, 0 2
                  buildWall gx + gr, gy + k, 0 2
               else
                  switch mod
                  | 0 => buildWall gx + k, gy - gr, 2 0
                  | 1 => buildWall gx + k, gy + gr, 2 0
                  | 2 => buildWall gx - gr, gy + k, 0 2
                  | 3 => buildWall gx + gr, gy + k, 0 2
            for k from -gr to gr by 2
               if mod == void
                  buildTower gx + k, gy - gr
                  buildTower gx + k, gy + gr
                  buildTower gx - gr, gy + k
                  buildTower gx + gr, gy + k
               else
                  switch mod
                  | 0 => buildTower gx + k, gy - gr
                  | 1 => buildTower gx + k, gy + gr
                  | 2 => buildTower gx - gr, gy + k
                  | 3 => buildTower gx + gr, gy + k
            rx = gr * COMMON.GRID_WIDTH - COMMON.GRID_WIDTH / 2
            ry = gr * COMMON.GRID_HEIGHT - COMMON.GRID_HEIGHT / 2
            mx = Math.round x + Utils.random -rx, rx
            my = Math.round y + Utils.random -ry, ry
            # await moveToXY mx, my
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
