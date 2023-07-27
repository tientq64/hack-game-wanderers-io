require! {
  "puppeteer-core": puppeteer
  lodash: _
}

await Promise.all Array.from (Array 4), (, i) !~>
  browser = await puppeteer.launch do
    headless: yes
    executablePath: "F:/chromium/chrome.exe"

  page = (await browser.pages!)0
  await page.goto \https://wanderers.io

  for j til 100
    try
      await page.click ".showMainMenu"
      await page.click ".modePicker > .ui-tabs > :nth-child(2)"
      unless j
        await page.type ".tribeName" "POKEMON #i"
        await page.type ".groupName" "POKEMON1"
      await page.click ".start"
      console.log "#j #i"
      await page.waitForTimeout 2000

    catch
      console.log "#j #i Error"

    await page.reload!
  await page.close!

  await browser.close!

process.exit!
