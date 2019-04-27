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

function wrapLink(editor, href) {
  editor.wrapInline({
    type: 'link',
    data: { href },
  })
  editor.moveToEnd()
}
function unwrapLink(editor) {
  editor.unwrapInline('link')
}

class SlateEditor extends React.Component {

  constructor(props){
    super(props)

    var { post } = this.props

    console.log(this.props)
    this.state = {
      title: (post.data.attributes.title || initialTitle),
      value: (post.data.attributes.body && htmlSerializer.deserialize(post.data.attributes.body) || initialValue ),
      public: (post.data.attributes.public || false),
      post: post || null
    };
  }

  togglePublic(e){
    e.preventDefault();
    this.setState({
      public: !this.state.public
    })
  }

  handleTitleChange(){
    if (this.refs.title.value != this.state.title) {
      localStorage.setItem('title', this.refs.title.value)
    }

    this.setState({
      title: this.refs.title.value,
    })
  }

  hasLinks = () => {
    const { value } = this.state
    return value.inlines.some(inline => inline.type === 'link')
  }

  onChange = ({ value }) => {
    if (value.document != this.state.value.document) {
      const string = htmlSerializer.serialize(value)
      localStorage.setItem('content', string)
    }
    this.setState({ value: value })
  }

  onPaste = (event, editor, next) => {
    if (editor.value.selection.isCollapsed) return next()

    const transfer = getEventTransfer(event)
    const { type, text } = transfer

    // switch (type) {
    //   case 'files': return this.handleOnDrop(files);
    //   case 'text': return onPasteText(event, change)
    //   case 'html': return onPasteHtml(event, change)
    //   default: break
    // }

    if (type !== 'text' && type !== 'html') return next()
    if (!isUrl(text)) return next()
    if (this.hasLinks()) {
      editor.command(unwrapLink)
    }
    editor.command(wrapLink, text)
  }

  handleSubmit() {
    var id = this.state.post.id || null
    var action = id === null ? '/posts' : ('/posts/' + id)

    var post = {
      title: this.state.title,
      body: htmlSerializer.serialize(this.state.value),
      public: this.state.public
    }

    localStorage.clear();

    $.ajax({
      url: action,
      dataType: 'json',
      type: 'POST',
      data: {
        post: post
      },
      success: function(data) {
        console.log(data)
        window.location = data.redirect_to
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(
          this.props.url, status, err.toString()
        )
      }.bind(this)
    });
  }

  render(){
    return (
      <div className="slate-editor">
        <input
          className="title"
          ref="title"
          type="text"
          onChange={this.handleTitleChange.bind(this)}
          placeholder="My post title"
          value={this.state.title}
        />

        <Editor
          spellCheck
          autoFocus
          plugins={plugins}
          value={this.state.value}
          onPaste={this.onPaste}
          onChange={this.onChange}
          renderNode={renderNode}
          renderMark={renderMark}
        />

        <div className="button-row">
          <button
            className="btn btn-outline mrm"
            onClick={this.togglePublic.bind(this)}
          >
            Public: {this.state.public.toString()}
          </button>

          <button
            className="btn btn-primary"
            onClick={this.handleSubmit.bind(this)}
          >
            Save
          </button>
        </div>

      </div>
    )
  }

}

export default SlateEditor;