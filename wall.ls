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
  loop
    try
      await page.goto \https://wanderers.io,
        waitUntil: \networkidle0
      break
    catch
      setLog i,, "Goto timeout"

  isFilledTribeName = no

  for j til 100
    try
      await page.click \.showMainMenu
      await page.click ".modePicker > .ui-tabs > :nth-child(2)"
      unless isFilledTribeName
        isFilledTribeName = Boolean await page.$eval \.tribeName (.value)
      unless isFilledTribeName
        await page.type \.tribeName "Builder"
        await page.type \.groupName "Builder"
      await page.click \.start
      await page.waitForFunction \CLIENT.Game.player
      setLog i, j

      await page.evaluate !~>
        game = CLIENT.Game
        game.camera.setFollow game.player
        game.music.channel.volume 0

        countdown = 100
        while countdown--
          sx = Utils.random 0 48
          sy = Utils.random 3 78
          ex = sx + 2
          ey = sy
          if game.walls.canConnect sx, sy, ex, ey
            game.send \buildWall {sx, sy, ex, ey}
            break

        # centerGx = 24
        # centerGy = 36
        # extend = 0
        # :build loop
        #   for sx from centerGx - extend to centerGx + extend by 4
        #     sy = centerGy - extend
        #     ex = sx + 2
        #     ey = sy
        #     if game.walls.canConnect sx, sy, ex, ey
        #       game.send \buildWall {sx, sy, ex, ey}
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
