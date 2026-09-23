const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await page.setViewportSize({ width: 375, height: 812 }); // iPhone X size
  await page.goto('http://localhost:3000');
  await page.waitForTimeout(5000); // Wait for animations
  await page.screenshot({ path: 'home_v4_search.png' });
  await browser.close();
})();
