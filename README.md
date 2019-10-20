# InOut2019-matic-card-game

A blockchain based card game built on the matic network.

## Instructions to run

Compile `Contract/cards.sol` using an IDE such as Remix.

Address of deployed contract:
0x4B8DB512784B303480E5697be0d10946Ca90f332

- Add two players using `addNewPlayer` on two different machines.
- Use `addNewCard` to add an _even_ number of cards to the deck.
- call `dealCards` to distribute cards among the 2 players.
- Use `pickAttri` ("attack" or "defence") to choose the attribute.
- Enter ID of card using `pickCard` to play your turn.
- Repeat until all cards are used.
- call `pickOverallWinner` to display the winner once all the cards have been used.

### Instructions to run the client

- To see the prototype UI, open `UI Prototype/file.html`
- To run the (incomplete) JavaScript client, start `fronted-integration-testing` with a simple server, such as `http-server`
