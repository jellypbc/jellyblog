import React from 'react'

import { Editor, getEventTransfer } from 'slate-react'
import { Value } from 'slate'
import Plain from 'slate-plain-serializer'
import Html from 'slate-html-serializer'
import moment from 'moment'

import isUrl from 'is-url'
import { isKeyHotkey } from 'is-hotkey'

import htmlSerializer from './editor/serializer'
import initialValue from './editor/initial'
import plugins from './editor/plugins/index'
import renderNode from './editor/renderer/renderNode'
import renderMark from './editor/renderer/renderMark'

const today = new Date();
const formattedDate = 'Journal for ' + moment(today).format('MMM Do, YYYY')
const initialTitle = localStorage.getItem('title') || formattedDate

const isBoldHotkey = isKeyHotkey('mod+b')
const isItalicHotkey = isKeyHotkey('mod+i')
const isUnderlinedHotkey = isKeyHotkey('mod+u')
const isCodeHotkey = isKeyHotkey('mod+`')
const isLinkHotkey = isKeyHotkey('mod+k')


class PostRenderer extends React.Component {

  constructor(props){
    super(props)

    var { post } = this.props

    this.state = {
      title: (post.data.attributes.title || initialTitle),
      value: (post.data.attributes.body && htmlSerializer.deserialize(post.data.attributes.body) || initialValue ),
      public: (post.data.attributes.public || false),
      post: post || null
    };
  }

  render(){
    return (
      <div className="slate-editor">
        <input
          className="title"
          ref="title"
          type="text"
          placeholder="My post title"
          value={this.state.title}
        />

        <Editor
          spellCheck
          autoFocus
          plugins={plugins}
          value={this.state.value}
          renderNode={renderNode}
          renderMark={renderMark}
          readOnly={true}
        />

      </div>
    )
  }

}

export default PostRenderer;