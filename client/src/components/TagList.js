import React from 'react';
import { Card, Header } from 'semantic-ui-react';
import { connect } from 'react-redux';
import { getUsersByTag } from '../actions/likeUsers';
import UserCard from './UserCard';
import InfiniteScroll from 'react-infinite-scroller';

const styles = {
  container: {
    height: '700px',
    overflow: 'auto',
  }
}

class TagList extends React.Component {
  state = { page: 1 }

  componentDidMount() {
    this.loadUsers()
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.users.length !== this.props.users.length)
      this.state({ page: this.state.page + 1 })
  }

  loadUsers = () => {
    const { page } = this.state;
    const { dispatch, match: { params: { tag } }} = this.props;
    dispatch(getUsersByTag(tag, page))
  }

  render() {
    const { users, total_pages } = this.props;
    const { page } = this.state;
    return (
      <div style={styles.container}>
        <InfiniteScroll
          loadMore={this.loadUsers}
          hasMore={page < total_pages}
          loader={<div>Loading...</div>}
          useWindow={false}
        >
          <Card.Group itemsPerRow={3}>
            { users.map( user =>
                <UserCard key={user.id} user={user} />
              )
            }
          </Card.Group>
        </InfiniteScroll>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  const { users, total_pages } = state.likeUsers;
  return { users, total_pages }
}

export default connect(mapStateToProps)(TagList)
