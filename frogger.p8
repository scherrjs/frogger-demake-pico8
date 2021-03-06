pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--author - j scherrer
--uses sprites from the game
--"frogger". sprite sheet found
--at spriters-resource.com
function _init()
 cls(0)
--counter to check car movement
 counter = 0
--counter to time frog movement 
 frogcount=0
--speed of vehicles
 speedlevel=1
--checking if frog is dying
 frogdead=0
--checking if a new frog has
--been created
 frog=0
--the value that frogcount will
--need to match to initiate
--movement
 frogcheck=flr(rnd(60))+1
--if frog is currently moving
 frogmove=false
--duration of frogs movement
--animation
 movecount=0
--duration of frogs death anim
 deathcount=0
--default values of frog
 froggy={x=128,y=128,sprite=3}
--initial pos values for trucks
 truck1={x=32,y=32}
 truck2={x=96,y=32}
 truck3={x=160,y=32}
--initial pos values for
--white racecars
 whiterace1={x=-16,y=48}
 whiterace2={x=-52,y=48}
 whiterace3={x=-16,y=16}
 whiterace4={x=-52,y=16}
--initial pos values for cars
 car1={x=0,y=64}
 car2={x=52,y=64}
 car3={x=104,y=64}
 car4={x=156,y=64}
--initial pos values for
--tractors
 tractor1={x=16,y=80}
 tractor2={x=96,y=80}
--initial pos values for yellow
--racecars
 yellowrace1={x=0,y=96}
 yellowrace2={x=52,y=96}
 yellowrace3={x=104,y=96}
 yellowrace4={x=156,y=96}
end
-->8
function _update()
--update counter and frog
--counter - different because
--frogcount is frequently reset
 counter=counter+1
 frogcount=frogcount+1
--increasing and decreasing
--speed from user input
 if btnp(2) then
  if(speedlevel<3) then
   speedlevel=speedlevel+1
  end
 end
 if btnp(3) then
  if(speedlevel>1) then
   speedlevel=speedlevel-1
  end
 end
--resets vehicles to other end
--of the screen when they drive
--off
 if truckrepos(truck1["x"]) then
  truck1["x"]=truck1["x"]+192
 end
 if truckrepos(truck2["x"]) then
  truck2["x"]=truck2["x"]+192
 end
 if truckrepos(truck3["x"]) then
  truck3["x"]=truck3["x"]+192
 end
 
 if whiterepos(whiterace1["x"]) then
  whiterace1["x"]=whiterace1["x"]-144
 end
 if whiterepos(whiterace2["x"]) then
  whiterace2["x"]=whiterace2["x"]-144
 end
 if whiterepos(whiterace3["x"]) then
  whiterace3["x"]=whiterace3["x"]-144
 end
 if whiterepos(whiterace4["x"]) then
  whiterace4["x"]=whiterace4["x"]-144
 end
 
 if leftrepos(car1["x"]) then
  car1["x"]=car1["x"]+192
 end
 if leftrepos(car2["x"]) then
  car2["x"]=car2["x"]+192
 end
 if leftrepos(car3["x"]) then
  car3["x"]=car3["x"]+192
 end
 if leftrepos(car4["x"]) then
  car4["x"]=car4["x"]+192
 end
 
 if leftrepos(yellowrace1["x"]) then
  yellowrace1["x"]=yellowrace1["x"]+192
 end
 if leftrepos(yellowrace2["x"]) then
  yellowrace2["x"]=yellowrace2["x"]+192
 end
 if leftrepos(yellowrace3["x"]) then
  yellowrace3["x"]=yellowrace3["x"]+192
 end
 if leftrepos(yellowrace4["x"]) then
  yellowrace4["x"]=yellowrace4["x"]+192
 end
 
 if tractrepos(tractor1["x"]) then
  tractor1["x"]=tractor1["x"]-160
 end
 if tractrepos(tractor2["x"]) then
  tractor2["x"]=tractor2["x"]-160
 end
--creates a new frog if the
--frog (somehow) makes it
--across the road
 if frogrepos(froggy["y"]) then
  newfrog()
 end
end
 
-->8
function _draw()
 cls(0)
--draw the flowers on each edge
 for i=0,128,16 do
  map(18,0,i,0,2,2)
 end
 for i=0,128,16 do
  map(18,0,i,111,2,2)
 end
--if no new frog has been
--created, create a new frog
 if (frog==0) then
  newfrog()
 end
--move all of the vehicles
 truck()
 whiterace()
 car()
 tractor()
 yellowrace()
--if the frog is not currently
--dying, check its collision
--against every vehicle
 if frogdead==0 then
  frogcoll(froggy["x"],froggy["y"],16,16,truck1["x"],truck1["y"],32,16)
  frogcoll(froggy["x"],froggy["y"],16,16,truck2["x"],truck2["y"],32,16)
  frogcoll(froggy["x"],froggy["y"],16,16,truck3["x"],truck3["y"],32,16)
  frogcoll(froggy["x"],froggy["y"],16,16,whiterace1["x"],whiterace1["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,whiterace2["x"],whiterace2["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,whiterace3["x"],whiterace3["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,whiterace4["x"],whiterace4["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,car1["x"],car1["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,car2["x"],car2["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,car3["x"],car3["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,car4["x"],car4["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,tractor1["x"],tractor1["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,tractor2["x"],tractor2["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,yellowrace1["x"],yellowrace1["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,yellowrace2["x"],yellowrace2["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,yellowrace3["x"],yellowrace3["y"],16,16)
  frogcoll(froggy["x"],froggy["y"],16,16,yellowrace4["x"],yellowrace4["y"],16,16)
  frogdraw()
--if frog is currently dying
--advance the death cycle
 elseif frogdead==1 then
  frogdeath()
 end
end

--controls animation of frog
--dying
function frogdeath()
--checks how many frames have
--passed and advances death
--animation at specific frames
 if deathcount<=5 then
  spr(36,froggy["x"],froggy["y"],2,2)
 elseif deathcount<=10 then
  spr(38,froggy["x"],froggy["y"],2,2)
 elseif deathcount<=15 then
  spr(40,froggy["x"],froggy["y"],2,2)
 elseif deathcount<=20 then
  spr(42,froggy["x"],froggy["y"],2,2)
--reset frog values
 else
  frog=0
  frogdead=0
  deathcount=-1
 end
--increase the frog death anim
--frame counter
 deathcount=deathcount+1
end
 
-->8
function newfrog()
--creates a new frog
--choose a random x position to
--create the frog at
 froggy["x"]=flr(rnd(112))
 froggy["y"]=128
 froggy["sprite"]=3
--resets any frog values that
--could have been at nonzero
--values based on frogs time
--of death
 movecount=0
 frogmove=false
 frogcount=0
--when frogcheck = frogcount,
--the frog moves
 frogcheck=flr(rnd(60))+1
--draw the new frog
 spr(3,froggy["x"],froggy["y"],2,2)
--frog is now created
 frog=1
end
 
-->8
function truck()
--moves trucks at different
--speed levels
 if (speedlevel==1) then
  if (counter%5==0) then
   truck1["x"]=truck1["x"]-1
   truck2["x"]=truck2["x"]-1
   truck3["x"]=truck3["x"]-1
  end
 elseif (speedlevel==2) then
  if (counter%5==0) then
   truck1["x"]=truck1["x"]-1
   truck2["x"]=truck2["x"]-1
   truck3["x"]=truck3["x"]-1
  end
 elseif (speedlevel==3) then
  if (counter%5==0) then
   truck1["x"]=truck1["x"]-3
   truck2["x"]=truck2["x"]-3
   truck3["x"]=truck3["x"]-3
  end
 end
--draw the trucks
 spr(32,truck1["x"],truck1["y"],4,2)
 spr(32,truck2["x"],truck2["y"],4,2)
 spr(32,truck3["x"],truck3["y"],4,2)
end
-->8
function whiterace()
--moves white racecars at
--different speed levels
 if (speedlevel==1) then
  if (counter%5==0) then
   whiterace1["x"]=whiterace1["x"]+4
   whiterace2["x"]=whiterace2["x"]+4
   whiterace3["x"]=whiterace3["x"]+4
   whiterace4["x"]=whiterace4["x"]+4
  end
 elseif (speedlevel==2) then
  if (counter%5==0) then
   whiterace1["x"]=whiterace1["x"]+8
   whiterace2["x"]=whiterace2["x"]+8
   whiterace3["x"]=whiterace3["x"]+8
   whiterace4["x"]=whiterace4["x"]+8
  end
 elseif (speedlevel==3) then
  if (counter%5==0) then
   whiterace1["x"]=whiterace1["x"]+12
   whiterace2["x"]=whiterace2["x"]+12
   whiterace3["x"]=whiterace3["x"]+12
   whiterace4["x"]=whiterace4["x"]+12
  end
 end
--draw the white racecars
 spr(9,whiterace1["x"],whiterace1["y"],2,2)
 spr(9,whiterace2["x"],whiterace2["y"],2,2)
 spr(9,whiterace3["x"],whiterace3["y"],2,2)
 spr(9,whiterace4["x"],whiterace4["y"],2,2)
end
-->8
function car()
--moves cars at different
--speed levels
 if (speedlevel==1) then
  if (counter%5==0) then
   car1["x"]=car1["x"]-1
   car2["x"]=car2["x"]-1
   car3["x"]=car3["x"]-1
   car4["x"]=car4["x"]-1
  end
 elseif (speedlevel==2) then
  if (counter%5==0) then
   car1["x"]=car1["x"]-3
   car2["x"]=car2["x"]-3
   car3["x"]=car3["x"]-3
   car4["x"]=car4["x"]-3
  end
 elseif (speedlevel==3) then
  if (counter%5==0) then
   car1["x"]=car1["x"]-5
   car2["x"]=car2["x"]-5
   car3["x"]=car3["x"]-5
   car4["x"]=car4["x"]-5
  end
 end
--draw the cars
 spr(5,car1["x"],car1["y"],2,2)
 spr(5,car2["x"],car2["y"],2,2)
 spr(5,car3["x"],car3["y"],2,2)
 spr(5,car4["x"],car4["y"],2,2)
end
-->8
function tractor()
--moves tractors at different
--speed levels
 if (speedlevel==1) then
  if (counter%5==0) then
   tractor1["x"]=tractor1["x"]+1
   tractor2["x"]=tractor2["x"]+1
  end
 elseif (speedlevel==2) then
  if (counter%5==0) then
   tractor1["x"]=tractor1["x"]+3
   tractor2["x"]=tractor2["x"]+3
  end
 elseif (speedlevel==3) then
  if (counter%5==0) then
   tractor1["x"]=tractor1["x"]+5
   tractor2["x"]=tractor2["x"]+5
  end
 end
--draw the tractors
 spr(11,tractor1["x"],tractor1["y"],2,2)
 spr(11,tractor2["x"],tractor2["y"],2,2)
end
-->8
function yellowrace()
--moves yellow racecars at
--different speed levels
 if (speedlevel==1) then
  if (counter%5==0) then
   yellowrace1["x"]=yellowrace1["x"]-1
   yellowrace2["x"]=yellowrace2["x"]-1
   yellowrace3["x"]=yellowrace3["x"]-1
   yellowrace4["x"]=yellowrace4["x"]-1
  end
 elseif (speedlevel==2) then
  if (counter%5==0) then
   yellowrace1["x"]=yellowrace1["x"]-3
   yellowrace2["x"]=yellowrace2["x"]-3
   yellowrace3["x"]=yellowrace3["x"]-3
   yellowrace4["x"]=yellowrace4["x"]-3
  end
 elseif (speedlevel==3) then
  if (counter%5==0) then
   yellowrace1["x"]=yellowrace1["x"]-5
   yellowrace2["x"]=yellowrace2["x"]-5
   yellowrace3["x"]=yellowrace3["x"]-5
   yellowrace4["x"]=yellowrace4["x"]-5
  end
 end
--draw the yellow racecars
 spr(7,yellowrace1["x"],yellowrace1["y"],2,2)
 spr(7,yellowrace2["x"],yellowrace2["y"],2,2)
 spr(7,yellowrace3["x"],yellowrace3["y"],2,2)
 spr(7,yellowrace4["x"],yellowrace4["y"],2,2)
end
-->8
function truckrepos(truckx)
--if a truck leaves the screen,
--set it back on the other side
 if (truckx<=-32) then
  return true
 end
end
-->8
function whiterepos(whitex)
--if a white racecar leaves the
--screen, set it back on the
--other side
 if (whitex>=128) then
  return true
 end
end
-->8
function leftrepos(leftx)
--if a car or yellow racecar
--leaves the screen, set it
--back on the other side
 if (leftx<=-16) then
  return true
 end
end
-->8
function tractrepos(tractx)
--if a tractor leaves the
--screen, set it back on the
--other side
 if (tractx>=128) then
  return true
 end
end
-->8
function frogdraw()
--checks how and where to draw
--the frog
--checks if it is time for the
--frog to move
 if (frogcheck==frogcount) then
  frogmove=true
 end
--updates the time that the
--frog has been moving
 if frogmove then
  movecount=movecount+1
 end
--moves the frog forward and
--changes to jump sprite if
--its the first frame of move
 if movecount==1 then
  froggy["y"]=froggy["y"]-8
  froggy["sprite"]=1
--after five frames, moves
--frog forward and changes to
--sitting sprite
 elseif movecount==6 then
  froggy["y"]=froggy["y"]-8
  froggy["sprite"]=3
--resets associated values
  movecount=0
  frogmove=false
  frogcount=0
--determines when frog will
--jump next
  frogcheck=flr(rnd(60))+1
 end
--draw the frog
 spr(froggy["sprite"],froggy["x"],froggy["y"],2,2)
end
 
-->8
function frogrepos(frogy)
--if frog somehow makes it
--across the road, creates a
--new frog and starts over
 if (frogy<=-16) then
  return true
 end
end
-->8
function frogcoll(
  x1,y1,
  w1,h1,
  x2,y2,
  w2,h2)
--collision function - checks
--if the distance between
--center of object bounding
--boxes is less than their
--half-widths and half-heights
--combined
  hit=false
  local xd=abs((x1+(w1/2))-(x2+(w2/2)))
  local xs=w1*0.5+w2*0.5
  local yd=abs((y1+(h1/2))-(y2+(h2/2)))
  local ys=h1/2+h2/2
--if the frog hit something,
--start the death sequence
  if xd<xs and 
     yd<ys then 
    frogdead=1 
  end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000088888008888800000000000000000000000000000000000000000000000000
00700700000b00000000b00000000000000000000000000000000000008888800088888008888800088888000878787800007770000000000000000000000000
0007700000bb00abaa00bb00000b00abaa00b0000000bb00000bbb00008888800088888008888800088888000878787800007800000000000000000000000000
00077000000b02baab20b00000bb02baab20bb0000ceeeee00eeeee00000200000002000000b0000000b000000b000b00bbb7770000000000000000000000000
00700700000b0bbaabb0b000000b0bbaabb0b0000ceeeecceceeeeec00aaaaaaaaaaaa0007777777777777000077777777007800000000000000000000000000
000000000000baaaaaab0000000bbaaaaaabb0000cbeecceeeeccce00aaaa222aa222222bbbbbb77bbb77770077777bb7b007770000000000000000000000000
0000000000000abaaaa0000000000abaaaa000000ceeecceeeeccce0aaaa222aa8a8a8a0008780877bbb7777077bbb7b77007800000000000000000000000000
0000000000000abaaaa00000000bbabaaaabb0000ceeecceeeeccce0aaaa222aa8a8a8a0078787877bbb7777077bbb7b77007800000000000000000000000000
0000000000000babaab00000000b0babaab0b0000cbeecceeeeccce00aaaa222aa222222bbbbbb77bbb77770077777bb7b007770000000000000000000000000
0000000000000bbaabb0000000bb00baab00bb000ceeeecceceeeeec00aaaaaaaaaaaa0007777777777777000077777777007800000000000000000000000000
000000000000bb0000bb0000000b00000000b00000ceeeee00eeeee00000200000002000000b0000000b000000b000b00bbb7770000000000000000000000000
000000000000b000000b000000000000000000000000bb00000bbb00008888800088888008888800088888000878787800007800000000000000000000000000
00000000000bb000000bb00000000000000000000000000000000000008888800088888008888800088888000878787800007770000000000000000000000000
000000000000b000000b000000000000000000000000000000000000000000000088888008888800000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000aaa000000aaa00000000aaaaa0000002002200200220000000000000000000
000000000000000000000000000000000000a000000a000000aa00222200aa000aaa02222220aaa000000aaaaaaa000022222222202222220000000000000000
00000000000000000000000000000000000aaa0000aaa0000aaa2a2222a2aaa0aaa2222222222aaa0000aa0aaa0aa00022122221222221220000000000000000
000000bbb00bbbb00000000000bbb00000aaa222222aaa000aa2aaa22aaa2aa0a022aaa22aaa220a0000a0aaaaa0a00021812218122218120000000000000000
00008777707777777777777777777700000a28822882a000000288a22a882000002aaaa22aaaa2000aa0aaaaaaaaa0aa22122221222221220000000000000000
000877777077777777777777777777000000288228820000002a8aa22aa8a2000028aaa22aaa82000aa000aaaaa000aa22222222821222220000000000000000
000877777877777777777777777777000002aaa22aaa2000002aaa2222aaa20002288aa22aa88220000a000aaa000a0022212222818122220000000000000000
000877777877777777777777777777000002aa2222aa2000002aa222222aa20002288a2222a882200000a0000000a00022181221821222220000000000000000
0008777778777777777777777777770000082222222220000022222222222200022222222222222000000a00000a000022212218122222220000000000000000
0008777778777777777777777777770000082a22222220000022a222222222000222222222222220000000a000a0000022222221222212220000000000000000
0008777770777777777777777777770000008a22222200000002a22222222000002a2222222222000000000a0a00000021222222822181220000000000000000
00008777707777777777777777777700000022a22222a0000aaa2a222222aaa0002a22222222220000000000a000000018122222122212220000000000000000
000000bbb00bbb000000000000bbb000000aa222222aaa000aaaa222222aaaa00a22a222222222aa0000000a0a00000021221221812222220000000000000000
000000000000000000000000000000000000aaa000aaa000000aa000000aa0000aa2222222222aaa000000a000a0000022218122122222220000000000000000
0000000000000000000000000000000000000a00000a0000000000000000000000aa02222220aa000000aa00000aa00022221222222222220000000000000000
000000000000000000000000000000000000000000000000000000000000000000aaa000000aaa000000aa00000aa00022122002002000000000000000000000
__map__
0000000000000000000000000000000000002c2d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000003c3d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
