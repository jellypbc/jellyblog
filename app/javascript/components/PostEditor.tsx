import * as React from 'react'
import * as ReactDOM from 'react-dom'

import { Editor } from 'slate-react'
import htmlSerializer from './editor/serializer'
import initialValue from './editor/initial'


class PostEditor extends React.Component<any, any> {

  constructor(props: any){
    super(props)

    this.state = {
      body: (this.props.post.body && htmlSerializer.deserialize(this.props.post.body) || initialValue ),
    }
  }

  componentDidMount(){
    console.log(this.props)
  }

  render(){
    return (
      <div>

        <div>Hello World</div>

        <Editor
          value={this.state.body}
        />

      </div>
    )
  }

}

export default PostEditor;