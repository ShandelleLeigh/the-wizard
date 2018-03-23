import React from 'react';
import { connect } from 'react-redux';
import {
  Card,
  Divider,
  List,
  Image
} from 'semantic-ui-react';
import { getLikeUsers } from '../actions/likeUsers';
import UserCard from './UserCard'

class LikeUsers extends React.Component {
  componentDidMount() {
    this.reload();
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.tags !== this.props.tags)
      this.reload()
  }

  reload = () => {
    this.props.dispatch(getLikeUsers())
  }

  render() {
    const { likeUsers } = this.props;
    return (
      <Card.Group itemsPerRow={4}>
        { users.map( user =>
          <UserCard key={user.id} user={user} />
          )
        }
      </Card.Group>
    )
  }
}

const mapStateToProps = (state) => {
  const { users, total_pages } = state.likeUsers;
  return {
    tags: state.tags,
    users,
    total_pages,
  }
}

export default connect(mapStateToProps)(LikeUsers)
