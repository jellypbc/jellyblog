// e.g. https://medium.com/@dan_bloom/webpack-and-rails-the-should-knows-a686aaf7017

export default {
  token() {
    const token = document.querySelector('meta[name="csrf-token"]');
    if (token && token instanceof window.HTMLMetaElement) {
      return token.content;
    }
    return null;
  },
};