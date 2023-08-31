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

  for j til 100
    try
      await page.click ".showMainMenu"
      await page.click ".modePicker > .ui-tabs > :nth-child(2)"
      await page.waitForFunction do
        ~>
          document.querySelector \.tribeName .value = "FARMER"
          document.querySelector \.groupName .value = "FARMER"
          yes
      await page.click ".start"
      setLog i, j
      await page.waitForTimeout 2000

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
