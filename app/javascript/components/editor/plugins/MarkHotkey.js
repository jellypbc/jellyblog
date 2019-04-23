function MarkHotkey(options) {
  const { type, key, isShiftKey = false } = options
  // Return our "plugin" object, containing the `onKeyDown` handler.
  return {
    onKeyDown(event, change, next) {
      // Check that the key pressed matches our `key` option.
      // if (!event.ctrlKey || event.key != key) return next()
      if (!event.metaKey || event.key !== key || event.shiftKey !== isShiftKey) return next()
      // Prevent the default characters from being inserted.
      event.preventDefault()
      // Toggle the mark `type`.
      change.toggleMark(type)
      return next()
    },
  }
}

module.exports = MarkHotkey;
