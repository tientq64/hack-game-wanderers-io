require! {
   "puppeteer-core": puppeteer
}

blockUrls =
   \https://spritestack.io/promo
   \https://www.google-analytics.com
   \https://www.googletagmanager.com
   \https://syndication.twitter.com
   \https://platform.twitter.com
   \https://wanderers.io/client/server/EU/Sandbox/undefined
   \https://wanderers.io/style/menu.gif
   \https://wanderers.io/fonts
   \https://wanderers.io/sounds/music/menu.ogg
   \https://stats.g.doubleclick.net

names = <[
   Bulbasaur Ivysaur Venusaur Charmander Charmeleon Charizard Squirtle Wartortle Blastoise Caterpie Metapod Butterfree Weedle Kakuna Beedrill Pidgey Pidgeotto Pidgeot Rattata Raticate Spearow Fearow Ekans Arbok Pikachu Raichu Sandshrew Sandslash Nidoranf Nidorina Nidoqueen Nidoranm Nidorino Nidoking Clefairy Clefable Vulpix Ninetales Jigglypuff Wigglytuff Zubat Golbat Oddish Gloom Vileplume Paras Parasect Venonat Venomoth Diglett Dugtrio Meowth Persian Psyduck Golduck Mankey Primeape Growlithe Arcanine Poliwag Poliwhirl Poliwrath Abra Kadabra Alakazam Machop Machoke Machamp Bellsprout Weepinbell Victreebel Tentacool Tentacruel Geodude Graveler Golem Ponyta Rapidash Slowpoke Slowbro Magnemite Magneton Farfetchd Doduo Dodrio Seel Dewgong Grimer Muk Shellder Cloyster Gastly Haunter Gengar Onix Drowzee Hypno Krabby Kingler Voltorb Electrode Exeggcute Exeggutor Cubone Marowak Hitmonlee Hitmonchan Lickitung Koffing Weezing Rhyhorn Rhydon Chansey Tangela Kangaskhan Horsea Seadra Goldeen Seaking Staryu Starmie Mrmime Scyther Jynx Electabuzz Magmar Pinsir Tauros Magikarp Gyarados Lapras Ditto Eevee Vaporeon Jolteon Flareon Porygon Omanyte Omastar Kabuto Kabutops Aerodactyl Snorlax Articuno Zapdos Moltres Dratini Dragonair Dragonite Mewtwo Mew Chikorita Bayleef Meganium Cyndaquil Quilava Typhlosion Totodile Croconaw Feraligatr Sentret Furret Hoothoot Noctowl Ledyba Ledian Spinarak Ariados Crobat Chinchou Lanturn Pichu Cleffa Igglybuff Togepi Togetic Natu Xatu Mareep Flaaffy Ampharos Bellossom Marill Azumarill Sudowoodo Politoed Hoppip Skiploom Jumpluff Aipom Sunkern Sunflora Yanma Wooper Quagsire Espeon Umbreon Murkrow Slowking Misdreavus Unown Wobbuffet Girafarig Pineco Forretress Dunsparce Gligar Steelix Snubbull Granbull Qwilfish Scizor Shuckle Heracross Sneasel Teddiursa Ursaring Slugma Magcargo Swinub Piloswine Corsola Remoraid Octillery Delibird Mantine Skarmory Houndour Houndoom Kingdra Phanpy Donphan Porygon2 Stantler Smeargle Tyrogue Hitmontop Smoochum Elekid Magby Miltank Blissey Raikou Entei Suicune Larvitar Pupitar Tyranitar Lugia Hooh Celebi Treecko Grovyle Sceptile Torchic Combusken Blaziken Mudkip Marshtomp Swampert Poochyena Mightyena Zigzagoon Linoone Wurmple Silcoon Beautifly Cascoon Dustox Lotad Lombre Ludicolo Seedot Nuzleaf Shiftry Taillow Swellow Wingull Pelipper Ralts Kirlia Gardevoir Surskit Masquerain Shroomish Breloom Slakoth Vigoroth Slaking Nincada Ninjask Shedinja Whismur Loudred Exploud Makuhita Hariyama Azurill Nosepass Skitty Delcatty Sableye Mawile Aron Lairon Aggron Meditite Medicham Electrike Manectric Plusle Minun Volbeat Illumise Roselia Gulpin Swalot Carvanha Sharpedo Wailmer Wailord Numel Camerupt Torkoal Spoink Grumpig Spinda Trapinch Vibrava Flygon Cacnea Cacturne Swablu Altaria Zangoose Seviper Lunatone Solrock Barboach Whiscash Corphish Crawdaunt Baltoy Claydol Lileep Cradily Anorith Armaldo Feebas Milotic Castform Kecleon Shuppet Banette Duskull Dusclops Tropius Chimecho Absol Wynaut Snorunt Glalie Spheal Sealeo Walrein Clamperl Huntail Gorebyss Relicanth Luvdisc Bagon Shelgon Salamence Beldum Metang Metagross Regirock Regice Registeel Latias Latios Kyogre Groudon Rayquaza Jirachi Deoxys Turtwig Grotle Torterra Chimchar Monferno Infernape Piplup Prinplup Empoleon Starly Staravia Staraptor Bidoof Bibarel Kricketot Kricketune Shinx Luxio Luxray Budew Roserade Cranidos Rampardos Shieldon Bastiodon Burmy Wormadam Combee Vespiquen Pachirisu Buizel Floatzel Cherubi Ambipom Drifloon Drifblim Buneary Lopunny Mismagius Honchkrow Glameow Purugly Chingling Stunky Skuntank Bronzor Bronzong Bonsly Mimejr Happiny Chatot Spiritomb Gible Gabite Garchomp Munchlax Riolu Lucario Hippopotas Hippowdon Skorupi Drapion Croagunk Toxicroak Carnivine Finneon Lumineon Mantyke Snover Abomasnow Weavile Magnezone Lickilicky Rhyperior Tangrowth Electivire Magmortar Togekiss Yanmega Leafeon Glaceon Gliscor Mamoswine Porygonz Gallade Probopass Dusknoir Froslass Rotom Uxie Mesprit Azelf Dialga Palkia Heatran Regigigas Giratina Cresselia Phione Manaphy Darkrai Shaymin Arceus Victini Snivy Servine Serperior Tepig Pignite Emboar Oshawott Dewott Samurott Patrat Watchog Lillipup Herdier Stoutland Purrloin Liepard Pansage Simisage Pansear Simisear Panpour Simipour Munna Musharna Pidove Tranquill Unfezant Blitzle Zebstrika Roggenrola Boldore Gigalith Woobat Swoobat Drilbur Excadrill Audino Timburr Gurdurr Conkeldurr Tympole Palpitoad Seismitoad Throh Sawk Sewaddle Swadloon Leavanny Venipede Whirlipede Scolipede Cottonee Whimsicott Petilil Lilligant Sandile Krokorok Krookodile Darumaka Maractus Dwebble Crustle Scraggy Scrafty Sigilyph Yamask Cofagrigus Tirtouga Carracosta Archen Archeops Trubbish Garbodor Zorua Zoroark Minccino Cinccino Gothita Gothorita Gothitelle Solosis Duosion Reuniclus Ducklett Swanna Vanillite Vanillish Vanilluxe Emolga Karrablast Escavalier Foongus Amoonguss Frillish Jellicent Alomomola Joltik Galvantula Ferroseed Ferrothorn Klink Klang Klinklang Tynamo Eelektrik Eelektross Elgyem Beheeyem Litwick Lampent Chandelure Axew Fraxure Haxorus Cubchoo Beartic Cryogonal Shelmet Accelgor Stunfisk Mienfoo Mienshao Druddigon Golett Golurk Pawniard Bisharp Bouffalant Rufflet Braviary Vullaby Mandibuzz Heatmor Durant Deino Zweilous Hydreigon Larvesta Volcarona Cobalion Terrakion Virizion Reshiram Zekrom Kyurem Genesect
]>

await Promise.all Array.from (Array 4), (, i) !~>
   await new Promise (resolve) !~>
      setTimeout resolve, i * 5000

   browser = await puppeteer.launch do
      headless: yes
      executablePath: "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
      userDataDir: "F:/puppeteer-user-data-dir"
      args: <[
         --window-size=870,730
         --aggressive-cache-discard
         --disable-cache
         --disable-application-cache
         --disable-offline-load-stale-cache
         --disable-gpu-shader-disk-cache
         --media-cache-size=0
         --disk-cache-size=0
         --disable-extensions
         --disable-component-extensions-with-background-pages
         --disable-default-apps
         --no-default-browser-check
         --disable-notifications
         --disable-background-networking
         --disable-sync
      ]>

   page = (await browser.pages!)0
   page.setDefaultTimeout 10000
   await page.setRequestInterception yes
   page.on \request (req) !~>
      url = req.url!
      for blockUrl in blockUrls
         index = url.search blockUrl
         if index >= 0
            req.abort!
            return
      req.continue!
   loop
      try
         await page.goto \https://wanderers.io,
            waitUntil: \networkidle0
         break
      catch
         console.log "#i Goto timeout"

   for j til 100
      try
         await page.click ".showMainMenu"
         await page.click ".modePicker > .ui-tabs > :nth-child(2)"
         # name = names[Math.floor Math.random! * names.length]
         name = "FARMER"
         await page.waitForFunction (name) ~>
            document.querySelector \.tribeName .value = name
            document.querySelector \.groupName .value = "Vietnam"
            CLIENT.Game.server_url = \s14421783116
            yes
         ,, name
         await page.click ".start"
         await page.waitForFunction "CLIENT.Game.player"
         console.log "#i #j"
         await page.evaluate !~>
            {Game} = CLIENT
            minMapX = -470
            maxMapX = 2500
            minMapY = -470
            maxMapY = 2500
            wait = (ms) ~>
               new Promise (resolve) !~>
                  setTimeout resolve, ms
            castArr = (val) ~>
               if Array.isArray val => val
               else if val? => [val]
               else []
            getDistanceXYToPlayer = (x, y) ~>
               Math.hypot Game.player.x - x, Game.player.y - y
            getDistanceEntityToPlayer = (entity) ~>
               getDistanceXYToPlayer entity.x, entity.y
            checkIsEntityInMap = (entity) ~>
               minMapX < entity.x < maxMapX and minMapY < entity.y < maxMapY
            findEmptyStorageNearest = (names, maxDistance = 100) ~>
               names = castArr names
               storage = void
               distanceMin = Infinity
               for building in Game.entities.groups.buildings
                  if names.includes building.shared.key and building.shared.counter < 20
                     isInMap = checkIsEntityInMap building
                     distance = getDistanceEntityToPlayer building
                     if (isInMap and distance < maxDistance) and (building.shared.counter == 0 or distance < distanceMin)
                        distanceMin = distance
                        storage = building
                        break if building.shared.counter == 0
               storage
            moveToXY = (x, y) !~>
               distance = getDistanceXYToPlayer x, y
               Game.send \move {x, y}
               await wait distance * 15
            moveToEntity = (entity) !~>
               await moveToXY entity.x, entity.y
            moveRandom = !~>
               {x, y} = Game.player
               distance = Utils.random 0 1000
               angle = Math.random! * Math.PI * 2
               x = Math.round Utils.clamp (x + distance * Math.cos angle), minMapX, maxMapX
               y = Math.round Utils.clamp (y + distance * Math.sin angle), minMapY, maxMapY
               await moveToXY x, y
            interactStorage = (storage, count) !~>
               for i til count
                  Game.send \interact,
                     entity_sid: storage.sid
                     alt: yes
               await wait 1000
            Game.camera.setFollow Game.player
            Game.music.channel.volume 0

            king = Game.entities.groups.tribes.find (.shared.name == \Pepyakis)
            # if king and king.team != Game.player.team
            #    for key in [\wood \food \gold]
            #      for i til 8
            #        Game.send \drop,
            #          key: key
            #    for member in Game.player.members
            #       Game.send \stay,
            #          target: member.sid
            #    return

            # await moveRandom!

            # if king and king.team == Game.player.team
            if king
               x = king.x + Utils.random -200 200
               y = king.y + Utils.random -200 200
            # else
            #   x = 1990 + Utils.random -200 200
            #   y = 1240 + Utils.random -200 200

            # if Game.player.team == 0
            #   x = 1630 + Utils.random -200 200
            #   y = 1460 + Utils.random -200 200
            # else
            #   x = 400 + Utils.random -200 200
            #   y = 360 + Utils.random -200 200

            # x = 800 + Utils.random -200 200
            # y = 1000 + Utils.random -200 200

            await moveToXY x, y
            storageBuildName = Utils.random 0 1 and \wood_storage or \food_storage
            Game.send \buildAnywhere,
               x: Game.player.x
               y: Game.player.y
               key: storageBuildName
            await wait 1000
            if storage = findEmptyStorageNearest [\wood_storage \food_storage] 500
               await moveToEntity storage
               await interactStorage storage, 8
            {wood, food} = Game.playerData.resources
            while (wood or food) and !Game.player._remove
               needFindStorages = []
               needFindStorages.push \wood_storage if wood
               needFindStorages.push \food_storage if food
               if storage = findEmptyStorageNearest needFindStorages, 500
                  await moveToEntity storage
                  await interactStorage storage, 8
                  if Game.playerData.resources.wood == wood and Game.playerData.resources.food == food
                     break
                  {wood, food} = Game.playerData.resources
               else
                  break
            for i til 2
               Game.send \drop,
                  key: \gold
            await moveToXY 1120 675
            # for member in Game.player.members
            #    Game.send \stay,
            #       target: member.sid
            # Game.send \quick_chat,
            #   text: "join the FARMER team"
         await page.waitForTimeout 1000

      catch
         console.log "#i #j #{e.message}"

      loop
         try
            await page.reload do
               waitUntil: \networkidle0
            break
         catch
            console.log "#i #j Reload timeout"

   await page.close!
   await browser.close!

process.exit!
