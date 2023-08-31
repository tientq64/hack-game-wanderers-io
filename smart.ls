require! {
  "puppeteer-core": puppeteer
}

await Promise.all Array.from (Array 4), (, i) !~>
  browser = await puppeteer.launch do
    headless: yes
    executablePath: "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
    userDataDir: "F:/puppeteer-user-data-dir"
    args: <[
      --window-size=870,730
      --aggressive-cache-discard
      --disable-cache
      --disable-application-cache
      --disable-offline-load-stale-cache
      --disable-gpu-shader-disk-cache
      --media-cache-size=0
      --disk-cache-size=0
      --disable-extensions
      --disable-component-extensions-with-background-pages
      --disable-default-apps
      --no-default-browser-check
      --disable-notifications
      --disable-background-networking
      --disable-sync
    ]>

  page = (await browser.pages!)0
  loop
    try
      await page.goto \https://wanderers.io
      break
    catch
      console.log "#i Goto timeout"

  isFilledTribeName = no

  for j til 100
    try
      await page.click ".showMainMenu"
      await page.click ".modePicker > .ui-tabs > :nth-child(2)"
      unless isFilledTribeName
        isFilledTribeName = Boolean await page.$eval ".tribeName" (.value)
      unless isFilledTribeName
        await page.type ".tribeName" "FARMER"
        await page.type ".groupName" "123456789"
      await page.click ".start"
      await page.waitForFunction "CLIENT.Game.player"
      console.log "#i #j"
      await page.evaluate !~>
        {Game} = CLIENT
        minMapX = -470
        maxMapX = 2500
        minMapY = -470
        maxMapY = 2500
        wait = (ms) ~>
          new Promise (resolve) !~>
            setTimeout resolve, ms
        castArr = (val) ~>
          if Array.isArray val => val
          else if val? => [val]
          else []
        getDistanceXYToPlayer = (x, y) ~>
          Math.hypot Game.player.x - x, Game.player.y - y
        getDistanceEntityToPlayer = (entity) ~>
          getDistanceXYToPlayer entity.x, entity.y
        checkIsEntityInMap = (entity) ~>
          minMapX < entity.x < maxMapX and minMapY < entity.y < maxMapY
        findEmptyStorageNearest = (names, maxDistance = 100) ~>
          names = castArr names
          storage = void
          distanceMin = Infinity
          for building in Game.entities.groups.buildings
            if names.includes building.shared.key and building.shared.counter < 20
              isInMap = checkIsEntityInMap building
              distance = getDistanceEntityToPlayer building
              if (isInMap and distance < maxDistance) and (building.shared.counter is 0 or distance < distanceMin)
                distanceMin = distance
                storage = building
                break if building.shared.counter is 0
          storage
        moveToXY = (x, y) !~>
          distance = getDistanceXYToPlayer x, y
          Game.send \move {x, y}
          await wait distance * 15
        moveToEntity = (entity) !~>
          await moveToXY entity.x, entity.y
        moveRandom = !~>
          {x, y} = Game.player
          distance = Utils.random 0 1000
          angle = Math.random! * Math.PI * 2
          x = Math.round Utils.clamp (x + distance * Math.cos angle), minMapX, maxMapX
          y = Math.round Utils.clamp (y + distance * Math.sin angle), minMapY, maxMapY
          await moveToXY x, y
        interactStorage = (storage, count) !~>
          for i til count
            Game.send \interact,
              entity_sid: storage.sid
              alt: yes
          await wait 1000
        Game.camera.setFollow Game.player
        Game.music.channel.volume 0

        king = Game.entities.groups.tribes.find (.shared.name is \tamcxmuonchs)
        if king and king.team isnt Game.player.team
          # for key in [\wood \food \gold]
          #   for i til 8
          #     Game.send \drop,
          #       key: key
          for member in Game.player.members
            Game.send \stay,
              target: member.sid
          return

        # await moveRandom!

        if king and king.team is Game.player.team
          x = king.x + Utils.random -200 200
          y = king.y + Utils.random -200 200
        # else
        #   x = 1990 + Utils.random -200 200
        #   y = 1240 + Utils.random -200 200

        # if Game.player.team is 0
        #   x = 1630 + Utils.random -200 200
        #   y = 1460 + Utils.random -200 200
        # else
        #   x = 400 + Utils.random -200 200
        #   y = 360 + Utils.random -200 200

        # x = 800 + Utils.random -200 200
        # y = 1000 + Utils.random -200 200

        await moveToXY x, y
        storageBuildName = Utils.random 0 1 and \wood_storage or \food_storage
        Game.send \buildAnywhere,
          x: Game.player.x
          y: Game.player.y
          key: storageBuildName
        await wait 1000
        if storage = findEmptyStorageNearest [\wood_storage \food_storage] 500
          await moveToEntity storage
          await interactStorage storage, 8
        {wood, food} = Game.playerData.resources
        while (wood or food) and not Game.player._remove
          needFindStorages = []
          needFindStorages.push \wood_storage if wood
          needFindStorages.push \food_storage if food
          if storage = findEmptyStorageNearest needFindStorages, 500
            await moveToEntity storage
            await interactStorage storage, 8
            if Game.playerData.resources.wood is wood and Game.playerData.resources.food is food
              break
            {wood, food} = Game.playerData.resources
          else
            break
        for i til 2
          Game.send \drop,
            key: \gold
        for member in Game.player.members
          Game.send \stay,
            target: member.sid
        # Game.send \quick_chat,
        #   text: "join the FARMER team"
      await page.waitForTimeout 1000

    catch
      console.log "#i #j #{e.message}"

    loop
      try
        await page.reload!
        break
      catch
        console.log "#i #j Reload timeout"

  await page.close!
  await browser.close!

process.exit!
