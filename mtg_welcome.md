# Welcome to Magic: The Gathering

## Introduction: The Question

I initially decided to use magic cards as a data set with a very specific question in mind: is "power creep" real?

In the magic community, there is a sense that over time, individual magic cards have become more powerful across the board, which "breaks" the game - this is referred to as "power creep" In networked video games, developers can use patches to "nerf" and "buff" certain aspects of the game in order to make the game remain balanced, but in Magic, the only way to "nerf" an already-printed card is to ban it from tournament play - so the cards continue to exist throughout time, which makes it necesarry to take their power into consideration when creating new cards in order to keep the overall game balanced.

So my question is this: has the overall power of the cards "crept up" over time?

## The Problem

Magic is a really, really complicated game. there are 38,000 individually printed magic cards spread over approximately 200 "sets", all with different levels of "allowed" in professional tournament play. There of almost a hundred different "formats" for playing magic, all with unique rules about how the decks are constructed and what kinds of cards are allowed. Because the basic rules of the game are always subject to rules printed on the cards - the design space of the game is theoretically infinite. For this reason, it is difficult enough to evaluate cards individually, much less cards as part of the greater body of cards that are sets or the entirety of the game.

So, in order to get closer to the answer to my question about overall power, I have decided to focus on a very specific aspect of evaluating the power of cards. The idea of "strictly better".

## What does "strictly better" mean?

Look at these two cards:

Hill Giant | Roc of Kher Ridges
-|-
![Hill Giant](https://img.scryfall.com/cards/normal/en/dpa/47.jpg?1496785707) |![Roc of Kher Ridges](https://img.scryfall.com/cards/normal/en/2ed/171.jpg?1496793408)

These cards are an excellent example of "strictly better" - they have the exact same mana cost (one red and two colorless, for a converted mana cost of 3), the exact same power and toughness (3/3), but one has flying.

Now look at these two:

Hill Giant | Ogre Gatecrasher
-|-
![Hill Giant](https://img.scryfall.com/cards/normal/en/dpa/47.jpg?1496785707) |![Ogre Gatecrasher](https://img.scryfall.com/cards/normal/en/dis/67.jpg?1496454118)

Strictly speaking, Ogre Gatecrasher is _not_ strictly better than Hill Giant, because even though it does something else, that thing has the potential to harm the owner f the card. When Ogre Gatecrasher is played, the player who played him _must_ destroy a creature with defender, even if that creature is her own.

So when we are looking at "strictly better" cards, what are we looking at?
1. Mana Cost
2. Card Power and Toughness
3. Card Effects - But they have to be strict benefits or drawbacks! Flexibility of effect (i.e. the player has a choice about activating it) can achieve this.

## Methodology

My data comes from the scryfall API, which is an online database of all the magic cards ever printed.

I used a ruby script to extract and clean the data and to load it into a Bigquery Database. I used a ruby script (that is a work in progress!) to parse the Oracle_Text field of the data for card behaviors.

When I started slicing and dicing, I decied to limit my initial exploration to **Creature** cards from **Expansions** and **Core Sets** - which comes to about 8,000 cards instead of 38,000. This might seem like a big jump, but many of those 38,000 cards are rarely or never played by actual magic players, because they are from promotional sets or have been banned.
