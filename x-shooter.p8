pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
t=0

function _init()
 t=0

	ship = {
	 sp=1,
	 x=60,
	 y=100,
	 h=4,
	 p=0,
	 t=0,
	 imm=false,
	 box = {x1=0,y1=0,x2=7,y2=7}}
	bullets = {}
	enemies = {}
	for i=1,5 do 
	add(enemies, {
  sp=17,
  m_x=i*16,
  m_y=60-i*8,
  x=-32,
  y=-32,
  r=10,
  box = {x1=0,y1=0,x2=5,y2=4}
	})
	end
	start()
end

function start()
 _update = update_game
 _draw = draw_game
end

function game_over()
 _update = update_over
 _draw = draw_over
end

function update_over()
 
end

function draw_over()
 cls()
 print("game over",50,50,4)
end 

function abs_box(s)
 local box = {}
 box.x1 = s.box.x1 + s.x
 box.y1 = s.box.y1 + s.y
 box.x2 = s.box.x2 + s.x
 box.y2 = s.box.x2 + s.y
 return box
 
end


function coll(a,b)
 -- hmmmmm
 local box_a = abs_box(a)
 local box_b = abs_box(b)
 
 if box_a.x1 > box_b.x2 or
    box_a.y1 > box_b.y2 or
    box_b.x1 > box_a.x2 or
    box_b.y1 > box_a.y2 then
    return false 
 end
 
 return true    
end


function fire()
 local b = {
 	sp=3,
 	x=ship.x,
 	y=ship.y-5,
 	dx=0,
 	dy=-3,
 	box = {x1=2,y1=0,x2=5,y2=4}
 }
 add(bullets, b)
end


function update_game()
 t=t+1
 if ship.imm then
  ship.t += 1
  if ship.t >30 then
   ship.imm = false
   ship.t = 0
  end
 end
 
 for e in all(enemies) do
  e.x = e.r*sin(t/50) + e.m_x
  e.y = e.r*cos(t/50) + e.m_y
  if coll(ship,e) and not ship.imm then
   ship.imm = true 
   ship.h -= 1
   if ship.h <= 0 then
    game_over()
   end
  
  end
   
 end
 
 
 
	for b in all(bullets) do
	 b.x+=b.dx
	 b.y+=b.dy
	 if b.x < 0 or b.x > 128 or
	  b.y < 0 or b.y > 128 then
	  del(bullets, b)
	 end
	 
	 for e in all(enemies) do
	  if coll(b,e) then
	   del(enemies,e)
	   ship.p +=1
	  end
	 end
	end
	if(t%8<4) then
	 ship.sp=2
	 else
	 ship.sp=1
	end
	if btn(0) then ship.x-=2 end
	if btn(1) then ship.x+=2 end
	if btn(2) then ship.y-=2 end
	if btn(3) then ship.y+=2 end
	if btnp(4) then fire() end
	
end
	 
function draw_game()
	cls()
	print(ship.p,9)
	if not ship.imm or t%8 < 4 then
  spr(ship.sp, ship.x,ship.y)
 end
 for b in all(bullets) do
  spr (b.sp,b.x,b.y)
 end 
 for e in all(enemies) do
  spr(e.sp,e.x,e.y)
 end  

 for i=1,4 do
  if i<=ship.h then
  spr(33,80+6*i,3)
  else
  spr(34,80+6*i,3)
  end
 end
  
end
__gfx__
000000000003300000033000000cc000000000000000000080a0c0e0000000000000000000000000000000000000000000000000000000000000000000000000
000000000009900000099000000cc0000000000000000000171b1d7f000000000000000000000000000000000000000000000000000000000000000000000000
007007000093390000933900000cc0000000000000000000825775e2000000000000000000000000000000000000000000000000000000000000000000000000
000770000999999009999990000cc00000000000000000003957753f000000000000000000000000000000000000000000000000000000000000000000000000
000770009999999999999999000cc0000000000000000000847777e4000000000000000000000000000000000000000000000000000000000000000000000000
0070070099555599995555990000000000000000000000005977775f000000000000000000000000000000000000000000000000000000000000000000000000
00000000800550080805508000000000000000000000000087a6c676000000000000000000000000000000000000000000000000000000000000000000000000
000000000800008080000008000000000000000000000000797b7d7f000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000eee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ee70e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ee77e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ee77e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000e0eee0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000e00e000e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000e00e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080800000606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888880006666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088800000666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000002020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
