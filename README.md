# Shadow Maps

A pretty vanilla implementation of shadow maps in openGL 3.3,
done for CSCI 544 Advanced Computer Graphics Spring 2014, at the
Colorado School of Mines, Project 3.

Models that work with the viewer code can be found here:

- small:
  https://mega.co.nz/#!Kd5UibqC!0vRlRhSZmsGAzNqChEXqulxFHjhE4qaRLtWWd2fGGG0
- medium:
  https://mega.co.nz/#!LdQzjTBZ!GHzKOWa8Zhx357IT8_I5sQj3HQuOZavj35lumDOXUx4
- small + medium + large:
  https://mega.co.nz/#!3FJFVKBL!ri59V_SLqz1GkHu8uUW9lZvmfEax85CfV_bxhqXVT1o

# Screenshots

Stanford bunny, without PCF filtering:

![bunny](screenshots/bunny.png)

Stanford bunny, without PCF filtering, and with 64x64 shadow map.

![bunny](screenshots/bunny-64.png)

Beethoven bust, PCF square window size 3.

![beethoven](screenshots/beethoven.png)

Dragon, PCF square window size 3.

![dragon](screenshots/dragon.png)

Dragon, no PCF, with 256x256 shadow map.

![dragon-256](screenshots/dragon-256.png)

# Running

Compile with:

    make

Then run the viewer:

    ./viewer <model file>
