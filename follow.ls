require! {
   "puppeteer-core": puppeteer
}

await Promise.all Array.from (Array 4), (, i) !~>
   browser = await puppeteer.launch do
      headless: yes
      executablePath: "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
      userDataDir: "F:/puppeteer-user-data-dir"
      args: [
         "--window-size=870,730"
      ]

   page = (await browser.pages!)0
   await page.goto \https://wanderers.io

   isFilledTribeName = no

   for j til 100
      try
         await page.click ".showMainMenu"
         await page.click ".modePicker > .ui-tabs > :nth-child(2)"
         unless isFilledTribeName
            isFilledTribeName = Boolean await page.$eval ".tribeName" (.value)
         unless isFilledTribeName
            await page.type ".tribeName" "tien"
            await page.type ".groupName" ""
         await page.click ".start"
         await page.waitForFunction "CLIENT.Game.player"
         console.log "#j #i"
         await page.evaluate !~>
            {Game} = CLIENT
            wait = (ms) ~>
               new Promise (resolve) !~>
                  setTimeout resolve, ms
            getDistanceXYToPlayer = (x, y) ~>
               Math.hypot Game.player.x - x, Game.player.y - y
            moveToXY = (x, y) !~>
               distance = getDistanceXYToPlayer x, y
               Game.send \move {x, y}
               await wait distance * 15
            moveToEntity = (entity) !~>
               await moveToXY entity.x, entity.y
            Game.camera.setFollow Game.player
            Game.music.channel.volume 0
            king = Game.entities.groups.tribes.find (.shared.name is \Tribe932468)
            if king and king.team is Game.player.team
               {x, y} = king
            else
               x = 200
               y = 1000
            await moveToXY x, y
            for i til 8
               Game.send \drop,
                  key: \wood
            for i til 8
               Game.send \drop,
                  key: \food
            for i til 8
               Game.send \drop,
                  key: \gold
            for member in Game.player.members
               Game.send \stay,
                  target: member.sid
         await page.waitForTimeout 1000

      catch e
         console.log "#j #i #{e.message}"

      await page.reload!

   await page.close!
   await browser.close!

process.exit!
