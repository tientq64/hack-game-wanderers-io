require! {
   "puppeteer-core": puppeteer
   lodash: _
}

# names = <[
#    bulbasaur ivysaur venusaur charmander charmeleon charizard squirtle wartortle blastoise caterpie metapod butterfree weedle kakuna beedrill pidgey pidgeotto pidgeot rattata raticate spearow fearow ekans arbok pikachu raichu sandshrew sandslash nidoranF nidorina nidoqueen nidoranM nidorino nidoking clefairy clefable vulpix ninetales jigglypuff wigglytuff zubat golbat oddish gloom vileplume paras parasect venonat venomoth diglett dugtrio meowth persian psyduck golduck mankey primeape growlithe arcanine poliwag poliwhirl poliwrath abra kadabra alakazam machop machoke machamp bellsprout weepinbell victreebel tentacool tentacruel geodude graveler golem ponyta rapidash slowpoke slowbro magnemite magneton farfetchd doduo dodrio seel dewgong grimer muk shellder cloyster gastly haunter gengar onix drowzee hypno krabby kingler voltorb electrode exeggcute exeggutor cubone marowak hitmonlee hitmonchan lickitung koffing weezing rhyhorn rhydon chansey tangela kangaskhan horsea seadra goldeen seaking staryu starmie mrMime scyther jynx electabuzz magmar pinsir tauros magikarp gyarados lapras ditto eevee vaporeon jolteon flareon porygon omanyte omastar kabuto kabutops aerodactyl snorlax articuno zapdos moltres dratini dragonair dragonite mewtwo mew chikorita bayleef meganium cyndaquil quilava typhlosion totodile croconaw feraligatr sentret furret hoothoot noctowl ledyba ledian spinarak ariados crobat chinchou lanturn pichu cleffa igglybuff togepi togetic natu xatu mareep flaaffy ampharos bellossom marill azumarill sudowoodo politoed hoppip skiploom jumpluff aipom sunkern sunflora yanma wooper quagsire espeon umbreon murkrow slowking misdreavus unown wobbuffet girafarig pineco forretress dunsparce gligar steelix snubbull granbull qwilfish scizor shuckle heracross sneasel teddiursa ursaring slugma magcargo swinub piloswine corsola remoraid octillery delibird mantine skarmory houndour houndoom kingdra phanpy donphan porygon2 stantler smeargle tyrogue hitmontop smoochum elekid magby miltank blissey raikou entei suicune larvitar pupitar tyranitar lugia hoOh celebi treecko grovyle sceptile torchic combusken blaziken mudkip marshtomp swampert poochyena mightyena zigzagoon linoone wurmple silcoon beautifly cascoon dustox lotad lombre ludicolo seedot nuzleaf shiftry taillow swellow wingull pelipper ralts kirlia gardevoir surskit masquerain shroomish breloom slakoth vigoroth slaking nincada ninjask shedinja whismur loudred exploud makuhita hariyama azurill nosepass skitty delcatty sableye mawile aron lairon aggron meditite medicham electrike manectric plusle minun volbeat illumise roselia gulpin swalot carvanha sharpedo wailmer wailord numel camerupt torkoal spoink grumpig spinda trapinch vibrava flygon cacnea cacturne swablu altaria zangoose seviper lunatone solrock barboach whiscash corphish crawdaunt baltoy claydol lileep cradily anorith armaldo feebas milotic castform kecleon shuppet banette duskull dusclops tropius chimecho absol wynaut snorunt glalie spheal sealeo walrein clamperl huntail gorebyss relicanth luvdisc bagon shelgon salamence beldum metang metagross regirock regice registeel latias latios kyogre groudon rayquaza jirachi deoxys turtwig grotle torterra chimchar monferno infernape piplup prinplup empoleon starly staravia staraptor bidoof bibarel kricketot kricketune shinx luxio luxray budew roserade cranidos rampardos shieldon bastiodon burmy wormadam combee vespiquen pachirisu buizel floatzel cherubi ambipom drifloon drifblim buneary lopunny mismagius honchkrow glameow purugly chingling stunky skuntank bronzor bronzong bonsly mimeJr happiny chatot spiritomb gible gabite garchomp munchlax riolu lucario hippopotas hippowdon skorupi drapion croagunk toxicroak carnivine finneon lumineon mantyke snover abomasnow weavile magnezone lickilicky rhyperior tangrowth electivire magmortar togekiss yanmega leafeon glaceon gliscor mamoswine porygonZ gallade probopass dusknoir froslass rotom uxie mesprit azelf dialga palkia heatran regigigas giratina cresselia phione manaphy darkrai shaymin arceus victini snivy servine serperior tepig pignite emboar oshawott dewott samurott patrat watchog lillipup herdier stoutland purrloin liepard pansage simisage pansear simisear panpour simipour munna musharna pidove tranquill unfezant blitzle zebstrika roggenrola boldore gigalith woobat swoobat drilbur excadrill audino timburr gurdurr conkeldurr tympole palpitoad seismitoad throh sawk sewaddle swadloon leavanny venipede whirlipede scolipede cottonee whimsicott petilil lilligant sandile krokorok krookodile darumaka maractus dwebble crustle scraggy scrafty sigilyph yamask cofagrigus tirtouga carracosta archen archeops trubbish garbodor zorua zoroark minccino cinccino gothita gothorita gothitelle solosis duosion reuniclus ducklett swanna vanillite vanillish vanilluxe emolga karrablast escavalier foongus amoonguss frillish jellicent alomomola joltik galvantula ferroseed ferrothorn klink klang klinklang tynamo eelektrik eelektross elgyem beheeyem litwick lampent chandelure axew fraxure haxorus cubchoo beartic cryogonal shelmet accelgor stunfisk mienfoo mienshao druddigon golett golurk pawniard bisharp bouffalant rufflet braviary vullaby mandibuzz heatmor durant deino zweilous hydreigon larvesta volcarona cobalion terrakion virizion reshiram zekrom kyurem genesect
# ]>

browser = await puppeteer.launch do
   headless: yes
   executablePath: "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"

page = (await browser.pages!)0
await page.goto \https://wanderers.io

for i til 100
   try
      await page.click ".showMainMenu"
      await page.click ".modePicker > .ui-tabs > :nth-child(2)"
      unless i
         if team = process.argv[3] or ""
            await page.type ".tribeName" team
            await page.type ".groupName" team
      await page.click ".start"
      console.log i
      await page.waitForTimeout 2000

   catch
      console.log "#i Error"

      # await page.waitForTimeout 5000
      # await page.evaluate !~>
      #    {Game} = CLIENT
      #    Game.send \move,
      #       x: 0
      #       y: 0
      #    Game.camera.setFollow Game.player
      #    for i til 6
      #       Game.send \drop key: \food
      #       Game.send \drop key: \wood
      #       Game.send \drop key: \gold

   await page.reload!

   # ((page) !~>
   #    await page.waitForTimeout 30000
   #    await page.close!
   # ) page

process.exit!
