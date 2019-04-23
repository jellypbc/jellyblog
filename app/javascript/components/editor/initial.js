import { Value } from 'slate'
import html from './serializer'

const existingValue = localStorage.getItem('content')
const initialValue = html.deserialize(existingValue || '<p>Today I...</p>')

export default initialValue
