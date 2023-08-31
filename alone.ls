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

  for j til 100
    try
      await page.click ".showMainMenu"
      await page.click ".modePicker > .ui-tabs > :nth-child(2)"
      await page.$eval ".tribeName" (.value = (Math.random!toString 36 .split \. .at -1))
      await page.$eval ".groupName" (.value = (Math.random!toString 36 .split \. .at -1))
      await page.waitForTimeout 2000
      await page.click ".start"
      console.log "#j #i"
      await page.waitForTimeout 2000

    catch
      console.log "#j #i #{e.message}"

    await page.reload!

  await page.close!
  await browser.close!

process.exit!
