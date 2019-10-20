pragma solidity >=0.4.22 <0.6.0;

contract CardsV0 {
     // shuffle the keys for the cardID to car map
    function shuffle() public {
        for (uint256 i = 0; i < cardIDs.length; i++) {
            uint256 n = i + uint256(keccak256(abi.encodePacked(now))) % (cardIDs.length - i);
            uint256 temp = cardIDs[n];
            cardIDs[n] = cardIDs[i];
            cardIDs[i] = temp;
        }
    }
    // compare strings
     function compareStrings (string memory a, string memory b) public pure
       returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );

      }
    struct Card {
        string name;
        uint64 attack;
        uint64 defence;
    }

    struct Player {
        uint256 score;
        address user;
        mapping(uint => Card) cardsInHand;
        uint numberOfCards;
    }

    uint256 public cardId = 0;
    mapping(uint256 => Card) public cards;
    uint256[] public cardIDs;

    Player[] players;
    
    address turn;
    string attribute;
    
    Card c1;
    Card c2;
    uint noOfCardsPicked = 0;
    uint noOfRounds=0;
    // 2 if tie
    uint winner;

    event NewCard( uint256 indexed cardId );
    event NewPlayer( uint256 indexed playerId );

    function addNewCard(string memory name, uint64 atk, uint64 def) public {
        Card memory c = Card(name,atk,def);
        cards[cardId] = c;
        cardIDs.push(cardId);
        emit NewCard(cardId++);
    }

    function addNewPlayer() public {
        players.push(Player({score:0, user:msg.sender, numberOfCards: 0}));
    }

    function dealCards() public {
        //shuffle();
        for(uint256 i = 0; i<2; i++){
            if(i%2==0){
                Player storage p = players[0];
                p.cardsInHand[p.numberOfCards] = cards[cardIDs[i]];
                p.numberOfCards++;
            } else {
                Player storage p = players[1];
                p.cardsInHand[p.numberOfCards] = cards[cardIDs[i]];
                p.numberOfCards++;
            }
        }
        turn = players[0].user;
    }

    function getPlayerDetails(uint index) public view returns (string memory) {
        return players[index].cardsInHand[0].name;
    }
    function pickAttri(string memory attri) public {
        require(
            turn == msg.sender,
            "Not your turn"
            );
        attribute = attri;
        noOfCardsPicked = 0;
    }
  
    function pickCard(uint256 card) public{
        // TODO : Check if the card belongs to the player
        if(msg.sender == players[0].user){
            c1 = cards[card];
        } else {
            c2 = cards[card];
        }
        noOfCardsPicked++;
        if(noOfCardsPicked == 2){
            pickWinner();
        }
    }

    function getScoreOfP1() public view returns (uint256) {
        return players[0].score;
    }

    function getScoreOfP2() public view returns (uint256) {
        return players[1].score;
    }

    function restart() public {
        noOfRounds = 0;
        players[0].score = 0;
        players[0].numberOfCards = 0;
        players[1].score = 0;
        players[1].numberOfCards = 0;
        dealCards();
    }

    function pickOverallWinner() public view returns(string memory) {
        if(noOfRounds >= cardId/2) {
            if(players[0].score > players[1].score){
                return "Player 1 wins";
            }
            if(players[0].score > players[1].score){
                return "Player 2 wins";
            } else {
                return "Tie!";
            }
        } else {
            return("The game is not over!");
        }
    }

    function pickWinner() public{
        if(compareStrings(attribute, "attack")){
            if(c1.attack > c2.attack) {
                winner = 0;
                players[0].score++;
            } else if(c1.attack == c2.attack){
                winner = 2;
                players[1].score++;
                players[0].score++;
    
            } else {
                winner = 1;
                players[1].score++;
            }
        } else {
            if(c1.defence > c2.defence) {
                winner = 0;
                players[0].score++;
            } else if(c1.defence == c2.defence){
                winner = 2;
                players[1].score++;
                players[0].score++;
    
            } else {
                winner = 1;
                players[1].score++;
            }
        }
        noOfCardsPicked = 0;
        noOfRounds++;
        // if(noOfRounds == cardId/2) {
        //     pickOverallWinner();
        // }
        if(turn == players[0].user){
            turn = players[1].user;
        } else {
            turn = players[0].user;
        }
    }

    function getNumberOfCardsForPlayer(uint pid) public view returns (uint) {
        return players[pid].numberOfCards;
    }

    function getCardPerPlayer(uint pid, uint cid) public view returns (string memory) {
        return players[pid].cardsInHand[cid].name;
    }
}