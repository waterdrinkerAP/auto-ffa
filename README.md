# AutoFFA for WoW 3.3.5a / AzerothCore

A simple addon that sets Loot to Free For All when you are the leader of the party or raid.
Perfect for playing with bots, close friends or your spouse.

## INSTALLATION
1. Clone the repository or download it as a zip
2. Extract/copy AutoFFA into World of Warcraft/Interface/AddOns/
3. Make sure the resulting folder is Interface/AddOns/AutoFFA/
4. Restart WoW or type /reload.

## BEHAVIOR
- Sets loot to Free For All two seconds after joining or creating a group, or becoming the leader.
- Also sets loot to Free For All for existing groups when logging in or reloading the interface.
- Won't continually overwrite manual loot-method changes within an existing group.
- Won't try to change loot in Dungeon Finder groups that have locked loot rules.

## TEST
/run print(GetLootMethod())
Expected: freeforall nil nil (when grouped and the setting can be changed).

### Acknowledgments

Inspired by the original AutoFFA addon by [DavidFTX](https://github.com/DavidFTX/addons).

This version has been adapted for World of Warcraft 3.3.5a (Wrath of the Lich King), with improved group detection, leadership handling, and compatibility with AzerothCore.

### License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.
