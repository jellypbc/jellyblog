import React from 'react'
import ReactDOM from 'react-dom'
import { Editor } from 'slate-react'
import Plain from 'slate-plain-serializer'
import Html from 'slate-html-serializer'

import htmlSerializer from './editor/serializer'
import initialValue from './editor/initial'
import MarkHotkey from './editor/MarkHotkey'

import AutoReplace from 'slate-auto-replace'
import SoftBreak from 'slate-soft-break'
// import EditList from 'slate-edit-list'
// import PasteLinkify from 'slate-paste-linkify'

import moment from 'moment'

const plugins = [
  MarkHotkey({ key: 'b', type: 'bold' }),
  MarkHotkey({ key: '`', type: 'code' }),
  MarkHotkey({ key: 'i', type: 'italic' }),
  MarkHotkey({ key: '~', type: 'strikethrough' }),
  MarkHotkey({ key: 'u', type: 'underline' }),
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
  // EditList(),
  // PasteLinkify({
  //   type: 'link',
  //   hrefProperty: 'url',
  //   collapseTo: 'end'
  // })
]
const today = new Date();
const formattedDate = 'Journal for ' + moment(today).format('MMM Do, YYYY')
// const formattedDate = 'Journal for ' + (today.getMonth()+1)+' '+(today.getDate()) +', '+ today.getFullYear();

const initialTitle = localStorage.getItem('title') || formattedDate
console.log(initialTitle)

class PostForm extends React.Component {
  constructor(props){
    super(props);

    this.state = {
      title: (this.props.post.title || initialTitle),
      body: (this.props.post.body && htmlSerializer.deserialize(this.props.post.body) || initialValue ),
      public: (this.props.post.public || false)
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

  onChange = ({ value }) => {
    if (value.document != this.state.body.document) {
      const string = htmlSerializer.serialize(value)
      localStorage.setItem('content', string)
    }
    this.setState({ body: value })
  }

  onKeyDown = (event, change) => {
    if (!event.ctrlKey) return
    // Decide what to do based on the key code...
    switch (event.key) {
      // When "B" is pressed, add a "bold" mark to the text.
      case 'b': {
        event.preventDefault()
        change.toggleMark('bold')
        return true
      }
      case 'i': {
        event.preventDefault()
        change.toggleMark('italic')
        return true
      }
      // When "`" is pressed, keep our existing code block logic.
      case '`': {
        const isCode = change.value.blocks.some(block => block.type == 'code')
        event.preventDefault()
        change.setBlocks(isCode ? 'paragraph' : 'code')
        return true
      }
    }
  }

  handleSubmit() {
    var id = this.props.post.id || null
    var action = id === null ? '/posts' : ('/posts/' + id)

    var post = {
      title: this.state.title,
      body: htmlSerializer.serialize(this.state.body),
      public: this.state.public
    }

    console.log(id)
    console.log(action)
    console.log(post)

  //   localStorage.clear();

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
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }


  render() {  
    return (
      <div>
        <input
          className="title"
          ref="title"
          type="text"
          onChange={this.handleTitleChange.bind(this)}
          placeholder="title"
          value={this.state.title}
        />


        <Editor
          plugins={plugins}
          value={this.state.body}
          onChange={this.onChange}
          onKeyDown={this.onKeyDown}
          renderNode={this.renderNode}
          renderMark={this.renderMark}
          className="slate-editor"
        />

        <div className="button-row">
          <button
            className="btn btn-secondary"
            onClick={this.togglePublic.bind(this)}
          >
            Public: {this.state.public.toString()}
          </button>

          <input
            type="submit"
            value="Publish"
            className="btn btn-primary"
            onClick={this.handleSubmit.bind(this)}
          />
        </div>

      </div>
    )
  }

  renderNode = props => {
    switch (props.node.type) {
      case 'code':
        return (
          <pre {...props.attributes}>
            <code>{props.children}</code>
          </pre>
        )
      case 'paragraph':
        return <p {...props.attributes}>{props.children}</p>
      case 'quote':
        return <blockquote {...props.attributes}>{props.children}</blockquote>
      case 'hr':
        return <hr />
      case 'ul':
        return <ul {...props.attributes}>{props.children}</ul>
      case 'li':
        return <li {...props.attributes}>{props.children}</li>
      case 'h':
        const level = props.node.data.get('level')
        const Tag = `h${level}`
        return <Tag {...props.attributes}>{props.children}</Tag>
      case 'link':
        return <a {...props.attributes} href={props.node.data.get('url')}>{props.children}</a>
    }
  }
 
  renderMark = props => {
    switch (props.mark.type) {
      case 'bold':
        return <strong>{props.children}</strong>
      // Add our new mark renderers...
      case 'code':
        return <code>{props.children}</code>
      case 'italic':
        return <em>{props.children}</em>
      case 'strikethrough':
        return <del>{props.children}</del>
      case 'underline':
        return <u>{props.children}</u>
    }
  }
}

export default PostForm;
