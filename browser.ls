require! {
   "puppeteer-core": puppeteer
   "chalk"
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

   for j til 100
      try
         await page.click ".showMainMenu"
         await page.click ".modePicker > .ui-tabs > :nth-child(2)"
         await page.waitForFunction ~>
            document.querySelector \.tribeName .value = "Vietnam"
            document.querySelector \.groupName .value = "Vietnam"
            CLIENT.Game.server_url = \s14421783116
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
