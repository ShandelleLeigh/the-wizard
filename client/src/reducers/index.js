import { combineReducers } from 'redux';
import user from './user';
import flash from './flash';
import tags from './tags';
import likeUsers from './likeUsers';


const rootReducer = combineReducers({
  user,
  flash,
  tags,
  likeUsers,
});

export default rootReducer;
