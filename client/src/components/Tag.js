import React from 'react';
import { Link } from 'react-router-dom';
import { List } from 'semantic-ui-react';

const styles = {
  tag: {
    backgroundColor: 'lightblue',
    border: 'solid 2px darkblue',
    padding: '10px 10px',
    margin: '10px 10px',
    cursor: 'pointer',
  }
}

const Tag = ({
  tag,
  deletable,
  deleteAction
}) => (
  <List.Item style={styles.tag}>
    {deletable &&
      <List.Icon
        name="cancel"
        onClick={ () => deleteAction(tag.id) }
        />
      }
      <List.Content>
        <List.Header>
          <Link to={`/tags/${tag.name}`}>
            #{tag.name}
          </Link>
        </List.Header>
      </List.Content>
)
