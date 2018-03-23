const likeUsers = (state = { users: [], total_pages: 1 }, action) => {
  switch (action.type) {
    case 'LIKE_USERS':
      return action.users
    default:
      return state
  }
}

export default likeUsers;
