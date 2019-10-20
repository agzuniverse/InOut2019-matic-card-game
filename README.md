# InOut2019-matic-card-game

A blockchain based card game built on the matic network.

## Instructions to run

Address of deployed contract:
0xfdbC76D0A6e8c662a598EeA67e18d57fcb041Cf9

- Add yourself as a player (The above deployed contract already has one player and two cards added, it needs one more.)
- call `dealCards` to distribute cards among the 2 players.
- Use `pickAttri` ("attack" or "defence") then enter ID of card using `pickCard` to play your turn.
- call `pickOverallWinner` to display the winner once all the cards have been used.

### Instructions to run the client

- To see the prototype UI, open `UI Prototype/file.html`
- To run the (incomplete) JavaScript client, start `fronted-integration-testing` with a simple server, such as `http-server`
