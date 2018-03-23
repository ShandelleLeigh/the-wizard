import React from 'react';
import { Card, Image, List } from 'semantic-ui-react';
import Tag from './Tag';

const UserCard = ({ user }) => {
  const { id, name, image, tags = [] } = user;
  return (
    <Card key={id}>
      <Image src={image} />
      <Card.Content>
        <Card.Header>{name}</Card.Header>
        <Card.Description>
          <List divided horizontal>
            { tags.map( tag =>
                <Tag key={tag.id} tag={tag} />
            ) }
          </List>
        </Card.Description>
      </Card.Content>
    </Card>
  )
}

export default UserCard;
