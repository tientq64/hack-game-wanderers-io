require! {
  "puppeteer-core": puppeteer
  lodash: _
}

browser = await puppeteer.launch do
  headless: no
  executablePath: "F:/chromium/chrome.exe"
  defaultViewport: null
  args:
    "--window-size=800,600"
    "--window-position=460,140"
    "--disable-infobars"
    ...
  ignoreDefaultArgs:
    "--enable-automation"
    ...

[page] = await browser.pages!
page.close!

page = await browser.newPage!
await page.goto \https://wanderers.io

await page.click ".showMainMenu"
await page.click ".modePicker > .ui-tabs > :nth-child(2)"
await page.type ".tribeName" "Tien"
await page.type ".groupName" ""
await page.click ".start"

await page.waitForTimeout 4000

await page.evaluate !~>
  window.Game = CLIENT.Game

  Game.music.channel.volume 0
  Game.camera.setFollow Game.player

  moveX = Game.player.x
  moveY = Game.player.y

  function isMoving
    {x, y} = Game.player
    x - 8 < moveX < x + 8 and y - 8 < moveY < y + 8

  !function moveToXY x, y
    moveX := x
    moveY := y
    Game.send \move,
      x: x
      y: y

  !function moveToEntity entity
    moveToXY entity.x, entity.y

  !function plantPlant key, x, y
    Game.send \plantPlant,
      key: key
      x: x
      y: y

  meadow = Game.entities.groups.meadows.1
  moveToEntity meadow

  setInterval !~>
    unless isMoving!
      for i til 10
        {x, y} = Game.player
        {radius} = meadow
        x += _.random -radius, radius
        y += _.random -radius, radius
        plantPlant \corn x, y
  , 1000
