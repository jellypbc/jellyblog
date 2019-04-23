import React from 'react'

const renderNode = (props, editor, next) => {
  const { attributes, children, node } = props

  switch (node.type) {
    case 'code':
      return (
        <pre {...attributes}>
          <code>{children}</code>
        </pre>
      )
    case 'paragraph':
      return <p {...attributes}>{children}</p>
    case 'quote':
      return <blockquote {...attributes}>{children}</blockquote>
    case 'hr':
      return <hr />
    case 'ul':
      return <ul {...attributes}>{children}</ul>
    case 'li':
      return <li {...attributes}>{children}</li>
    case 'h':
      const level = node.data.get('level')
      const Tag = `h${level}`
      return <Tag {...attributes}>{children}</Tag>
    case 'link':
      return <a {...attributes} href={node.data.get('url')}>
        {children}
      </a>
    default:
      return next()
  }
}

export default renderNode;
