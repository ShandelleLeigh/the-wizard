import axios from 'axios';

export const updateUser = (id, user) => {
  return (dispatch) => {
    let { name, email, gamertag, file } = user;
    let data = new FormData()
    data.append('file', file)
    let url = `/api/users/${id}?name=${name}&email=${email}&gamertag=${gamertag}`
    axios.put(url, data)
      .then( res => {
        dispatch({
          type: 'USER',
          user: res.data,
          headers: res.headers
        })
      });
  }
}
