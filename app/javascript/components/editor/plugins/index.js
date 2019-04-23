import MarkHotkey from './MarkHotkey'
import AutoReplace from 'slate-auto-replace'
import SoftBreak from 'slate-soft-break'

// currently broken due to gitbook fork
// import SlateEditList from 'slate-edit-list'

// currently not working?
// import SlatePasteLinkify from 'slate-paste-linkify'

import MARKS from '../renderer/marks'
import BLOCKS from '../renderer/blocks'

const plugins = [
  MarkHotkey({ key: 'b', type: MARKS.BOLD }),
  MarkHotkey({ key: 'i', type: MARKS.ITALIC }),
  MarkHotkey({ key: '~', type: MARKS.STRIKETHROUGH }),
  MarkHotkey({ key: '`', type: MARKS.CODE, isShiftKey: true }),
  MarkHotkey({ key: 'u', type: MARKS.UNDERLINE }),
  MarkHotkey({ key: 'e', type: MARKS.HIGHLIGHT }),
  
  AutoReplace({
    trigger: ')',
    before: /(\(c)$/i,
    change: change => change.insertText('©')
  }),
  AutoReplace({
    trigger: 'space',
    before: /^(>)$/,
    change: change => change.setBlock('quote')
  }),
  AutoReplace({
    trigger: 'space',
    before: /^(-)$/,
    change: change => change.setBlock('li').wrapBlock('ul')
  }),
  AutoReplace({
    trigger: 'space',
    before: /^(#{1,6})$/,
    change: (change, event, matches) => {
      const [ hashes ] = matches.before
      const level = hashes.length
      return change.setBlock({
        type: 'h',
        data: { level }
      })
    }
  }),
  AutoReplace({
    trigger: 'enter',
    before: /^(-{3})$/,
    change: (change) => {
      return change.setBlock({
        type: 'hr',
        isVoid: true
      })
    }
  }),
  SoftBreak({
    shift: true,
    onlyIn: ['code']
  }),

  // SlateEditList({
  //   types: [BLOCKS.CHECK_LIST],
  //   typeItem: BLOCKS.CHECK_LIST_ITEM  
  // }),
  // SlateEditList({
  //   types: [BLOCKS.OL_LIST, BLOCKS.UL_LIST],
  //   typeItem: BLOCKS.LIST_ITEM
  // }),
  // SlatePasteLinkify()
]

export default plugins;