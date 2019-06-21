module.exports = {
  before(browser) {
    browser.url(`${browser.launchUrl}/create`);
  },

  'renders a create form': (browser) => {

    browser.expect.element('.qa-submit').to.have.attribute('disabled');


    browser.end();
  },
};
