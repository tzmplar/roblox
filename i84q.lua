type connection__DARKLUA_TYPE_a={disconnect:()->()}type Vector3__DARKLUA_TYPE_b=
vector&{angle:(v:Vector3__DARKLUA_TYPE_b,axis:Vector3__DARKLUA_TYPE_b?)->number,
ceil:()->Vector3__DARKLUA_TYPE_b,floor:()->Vector3__DARKLUA_TYPE_b,sign:()->
Vector3__DARKLUA_TYPE_b}local a a={cache={},load=function(b)if not a.cache[b]
then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()local b={
}do local function constructor()return setmetatable({_map={}},{__index=b})end b.
new=constructor function b.fire<T...>(c,...:T...)for d=#c,1,-1 do local e=c[d]if
e then if'function'==type(e)then coroutine.wrap(e)(...)elseif'thread'==type(e)
then coroutine.resume(e,...)end end end return c end function b.connect<T...>(c,
d:(T...)->()):connection__DARKLUA_TYPE_a table.insert(c,d)return{disconnect=
function()local e=table.find(c,d)if e then table.remove(c,e)end end}end function
b.once<T...>(c,d:(T...)->()):connection__DARKLUA_TYPE_a local e do e=c:connect(
function(...)d(...)e:disconnect()end)end return e end function b.wait<T...>(c):T
...local d=coroutine.running()c:once(function(...)coroutine.resume(d,...)end)
return coroutine.yield()end setmetatable(b,{__call=constructor})end return b end
function a.b()local b={}do function b.connect(c:string)local d=
websocket_connect(c)local e={}do local f={}function e.send(g,h:string)assert(
'string'==type(h),`websocket:send: message must be a string, got {type(h)}`)
websocket_send(d,h)end function e.on(g,h)assert('function'==type(h),`websocket:on: callback must be a function, got {
type(h)}`)table.insert(f,h)return{disconnect=function()assert('function'==type(h
),`connection:disconnect: callback must be a function, got {type(h)}`)local i=
table.find(f,h)if i then table.remove(f,i)end end}end function e.close(g)
websocket_close(d)end websocket_onmessage(d,function(...)for g,h in f do h(...)
end end)end return e end end return b end function a.c()return{decode=function(b
)return JSONDecode(b)end,encode=function(b)return JSONEncode(b)end}end function
a.d()return{get=function(b,c)assert('table'==type(b),`http.get: settings must be a table, got {
type(b)}`)assert('function'==type(c),`http.get: callback must be a function, got {
type(c)}`)if c then return spawn(function()return c(httpget(unpack(b)))end)else
return httpget(unpack(b))end end,post=function(b,c)assert('table'==type(b),`http.get: settings must be a table, got {
type(b)}`)assert('function'==type(c),`http.get: callback must be a function, got {
type(c)}`)if c then return spawn(function()return c(httppost(unpack(b)))end)else
return httppost(unpack(b))end end}end function a.e()return function(b,c)assert(
'table'==type(b),`map(t, callback): expected a table, got {type(b)}`)assert(
'function'==type(c),`map(t, callback): expected a function, got {type(c)}`)local
d={}do for e,f in b do d[e]=c(f,e,b)end end return d end end function a.f()local
b:(x:number,y:number,z:number)->Vector3__DARKLUA_TYPE_b local c={}do function c.
dot(d,e:Vector3__DARKLUA_TYPE_b):number assert('userdata'==type(e)and
getmetatable(e).__vector,`bad argument #1 to 'Vector3:dot' (Vector3 expected, got {
type(e)})`)return vector.dot(getmetatable(d).__vector,getmetatable(e).__vector)
end function c.cross(d,e:Vector3__DARKLUA_TYPE_b):Vector3__DARKLUA_TYPE_b
assert('userdata'==type(e)and getmetatable(e).__vector,`bad argument #1 to 'Vector3:cross' (Vector3 expected, got {
type(e)})`)local f:vector=vector.cross(getmetatable(d).__vector,getmetatable(e).
__vector)return b(f.x,f.y,f.z)end function c.angle(d,e:Vector3__DARKLUA_TYPE_b,f
:Vector3__DARKLUA_TYPE_b?):number assert('userdata'==type(e)and getmetatable(e).
__vector,`bad argument #1 to 'Vector3:angle' (Vector3 expected, got {type(e)})`)
assert(f==nil or('userdata'==type(f)and getmetatable(f).__vector),`bad argument #2 to 'Vector3:angle' (Vector3 expected, got {
type(f)})`)return vector.angle(getmetatable(d).__vector,getmetatable(e).__vector
,f and getmetatable(f).__vector or nil)end function c.ceil(d):
Vector3__DARKLUA_TYPE_b local e:vector=vector.ceil(getmetatable(d).__vector)
return b(e.x,e.y,e.z)end function c.floor(d):Vector3__DARKLUA_TYPE_b local e:
vector=vector.floor(getmetatable(d).__vector)return b(e.x,e.y,e.z)end function c
.sign(d):Vector3__DARKLUA_TYPE_b local e:vector=vector.sign(getmetatable(d).
__vector)return b(e.x,e.y,e.z)end function c.lerp(d,e:Vector3__DARKLUA_TYPE_b,f:
number):Vector3__DARKLUA_TYPE_b assert('userdata'==type(e)and getmetatable(e).
__vector,`bad argument #1 to 'Vector3:lerp' (Vector3 expected, got {type(e)})`)
assert('number'==type(f),`bad argument #2 to 'Vector3:lerp' (number expected, got {
type(f)})`)local g:vector=vector.lerp(getmetatable(d).__vector,getmetatable(e).
__vector,f)return b(g.x,g.y,g.z)end function c.array(d):{number}local e:vector=
getmetatable(d).__vector return{e.x,e.y,e.z}end end function b(d:number,e:number
,f:number):Vector3__DARKLUA_TYPE_b assert('number'==type(d),`bad argument #1 to 'Vector3.new' (number expected, got {
type(d)})`)assert('number'==type(e),`bad argument #2 to 'Vector3.new' (number expected, got {
type(e)})`)assert('number'==type(f),`bad argument #3 to 'Vector3.new' (number expected, got {
type(f)})`)local g=newproxy(true)do local h=getmetatable(g)h.__vector=vector.
create(d,e,f)function h.__index(i,j:string):any j=string.lower(j)if j=='unit'
then return vector.normalize(h.__vector)elseif j=='magnitude'then return vector.
magnitude(h.__vector)end return c[j]or h.__vector[j]end function h.__newindex(i,
j:string,k:any):()j=string.lower(j)assert('number'==type(k),`can't assign '{
type(k)}' to '{j}' (number expected)`)assert(j=='x'or j=='y'or j=='z',`attempt to index Vector3 with '{
j}'`)local l:vector=h.__vector h.__vector=vector.create(j=='x'and k or l.x,j==
'y'and k or l.y,j=='z'and k or l.z)end function h.__add(i,j:
Vector3__DARKLUA_TYPE_b):Vector3__DARKLUA_TYPE_b assert('userdata'==type(j)and
getmetatable(j).__vector,`bad argument #1 to 'Vector3 + Vector3' (Vector3 expected, got {
type(j)})`)local k:vector=h.__vector+getmetatable(j).__vector return b(k.x,k.y,k
.z)end function h.__sub(i,j:Vector3__DARKLUA_TYPE_b):Vector3__DARKLUA_TYPE_b
assert('userdata'==type(j)and getmetatable(j).__vector,`bad argument #1 to 'Vector3 - Vector3' (Vector3 expected, got {
type(j)})`)local k:vector=h.__vector-getmetatable(j).__vector return b(k.x,k.y,k
.z)end function h.__mul(i,j:number|Vector3__DARKLUA_TYPE_b):
Vector3__DARKLUA_TYPE_b if'number'==type(j)then local k:vector=h.__vector*j
return b(k.x,k.y,k.z)elseif'userdata'==type(j)and getmetatable(j).__vector then
local k:vector=vector.mul(h.__vector,getmetatable(j).__vector)return b(k.x,k.y,k
.z)else error(`bad argument #1 to 'Vector3 * (number | Vector3)' (number | Vector3 expected, got {
type(j)})`,2)end end function h.__div(i,j:number|Vector3__DARKLUA_TYPE_b):
Vector3__DARKLUA_TYPE_b if'number'==type(j)then local k:vector=h.__vector/j
return b(k.x,k.y,k.z)elseif'userdata'==type(j)and getmetatable(j).__vector then
local k:vector=vector.div(h.__vector,getmetatable(j).__vector)return b(k.x,k.y,k
.z)else error(`bad argument #1 to 'Vector3 / (number | Vector3)' (number | Vector3 expected, got {
type(j)})`,2)end end function h.__idiv(i,j:number|Vector3__DARKLUA_TYPE_b):
Vector3__DARKLUA_TYPE_b if'number'==type(j)then local k:vector=vector.idiv(h.
__vector,j)return b(k.x,k.y,k.z)elseif'userdata'==type(j)and getmetatable(j).
__vector then local k:vector=vector.idiv(h.__vector,getmetatable(j).__vector)
return b(k.x,k.y,k.z)else error(`bad argument #1 to 'Vector3 // (number | Vector3)' (number | Vector3 expected, got {
type(j)})`,2)end end function h.__unm(i):Vector3__DARKLUA_TYPE_b local j:vector=
-h.__vector return b(j.x,j.y,j.z)end function h.__eq(i,j:Vector3__DARKLUA_TYPE_b
):boolean assert('userdata'==type(j)and getmetatable(j).__vector,`bad argument #1 to 'Vector3 == Vector3' (Vector3 expected, got {
type(j)})`)return h.__vector==getmetatable(j).__vector end function h.__tostring
(i):string local j:vector=h.__vector return`{j.x}, {j.y}, {j.z}`end end return g
end return table.freeze{one=b(1,1,1),zero=b(0,0,0),xAxis=b(1,0,0),yAxis=b(0,1,0)
,zAxis=b(0,0,1),new=b,array=function(d:{number}):Vector3__DARKLUA_TYPE_b assert(
'table'==type(d),`bad argument #1 to 'Vector3.array' (table expected, got {type(
d)})`)local e:number=d[1]or d.x local f:number=d[2]or d.y local g:number=d[3]or
d.z return b(e,f,g)end}end function a.g()local b,c,d,e=math.abs,math.ceil,math.
floor,math.sign local f,g=math.max,math.min local h={}do local function
constructor(i:number,j:number)assert('number'==type(i),`Vector2.new: expected a number for x, got {
type(i)}`)assert('number'==type(j),`Vector2.new: expected a number for y, got {
type(j)}`)return setmetatable({x=i,y=j},h)end h.new=constructor function h.abs(i
)return constructor(b(i.x),b(i.y))end function h.cross(i,j)assert('table'==type(
j)and getmetatable(j)=='Vector2',`Vector2.cross: expected a Vector2, got {type(j
)}`)return i.x*j.y-i.y*j.x end function h.ceil(i)return constructor(c(i.x),c(i.y
))end function h.floor(i)return constructor(d(i.x),d(i.y))end function h.sign(i)
return constructor(e(i.x),e(i.y))end function h.angle(i,j,k:boolean?)assert(
'table'==type(j)and getmetatable(j)=='Vector2',`Vector2.angle: expected a Vector2, got {
type(j)}`)local l=i:dot(j)local m=i.magnitude*j.magnitude if m==0 then return 0
end local n=math.acos(l/m)if k then local o=i:cross(j)if o<0 then n=-n end end
return n end function h.dot(i,j)assert('table'==type(j)and getmetatable(j)==
'Vector2',`Vector2.dot: expected a Vector2, got {type(j)}`)return i.x*j.x+i.y*j.
y end function h.lerp(i,j,k:number)assert('table'==type(j)and getmetatable(j)==
'Vector2',`Vector2.lerp: expected a Vector2, got {type(j)}`)assert('number'==
type(k),`Vector2.lerp: expected a number for alpha, got {type(k)}`)return
constructor(i.x+(j.x-i.x)*k,i.y+(j.y-i.y)*k)end function h.max(i,...)for j,k in{
...}do assert('table'==type(k)and getmetatable(k)=='Vector2',`Vector2.max: expected a Vector2, got {
type(k)}`)i=constructor(f(i.x,k.x),f(i.y,k.y))end return i end function h.min(i,
...)for j,k in{...}do assert('table'==type(k)and getmetatable(k)=='Vector2',`Vector2.min: expected a Vector2, got {
type(k)}`)i=constructor(g(i.x,k.x),g(i.y,k.y))end return i end h.zero=
constructor(0,0)h.one=constructor(1,1)h.xAxis=constructor(1,0)h.yAxis=
constructor(0,1)h.__metatable='Vector2'function h.__add(i,j)if'number'==type(j)
then return constructor(i.x+j,i.y+j)end return constructor(i.x+j.x,i.y+j.y)end
function h.__sub(i,j)if'number'==type(j)then return constructor(i.x-j,i.y-j)end
return constructor(i.x-j.x,i.y-j.y)end function h.__mul(i,j)if'number'==type(j)
then return constructor(i.x*j,i.y*j)end return constructor(i.x*j.x,i.y*j.y)end
function h.__div(i,j)if'number'==type(j)then return constructor(i.x/j,i.y/j)end
return constructor(i.x/j.x,i.y/j.y)end function h.__index(i,j)j=string.lower(j)
if'magnitude'==j then return math.sqrt(i.x*i.x+i.y*i.y)end if'unit'==j then
local k=i.magnitude return k~=0 and constructor(i.x/k,i.y/k)or i end return
rawget(h,j)or i[j]end function h.__tostring(i)return`{i.x}, {i.y}`end end return
table.freeze(h)end function a.h()local b=a.load'f'local c,d,e,f=math.abs,math.
sqrt,math.sin,math.cos local g,h,i=math.acos,math.atan2,math.clamp
local function isVector3(j)return'table'==type(j)and getmetatable(j)=='Vector3'
end local function isCFrame(j)return'table'==type(j)and getmetatable(j)==
'CFrame'end local j={}do local function constructor(k:number,l:number,m:number,n
:number?,o:number?,p:number?,q:number?,r:number?,s:number?,t:number?,u:number?,v
:number?)assert('number'==type(k),`CFrame.new: expected a number for x, got {
type(k)}`)assert('number'==type(l),`CFrame.new: expected a number for y, got {
type(l)}`)assert('number'==type(m),`CFrame.new: expected a number for z, got {
type(m)}`)n=n or 1 o=o or 0 p=p or 0 q=q or 0 r=r or 1 s=s or 0 t=t or 0 u=u or
0 v=v or 1 return setmetatable({x=k,y=l,z=m,r00=n,r01=o,r02=p,r10=q,r11=r,r12=s,
r20=t,r21=u,r22=v},j)end local function fromQuaternion(k,l,m,n,o,p,q)local r=d(n
*n+o*o+p*p+q*q)if r==0 then return constructor(k,l,m)end n,o,p,q=n/r,o/r,p/r,q/r
local s,t,u=n*n,o*o,p*p local v,w,x=n*o,n*p,o*p local y,z,A=q*n,q*o,q*p local B=
1-2*(t+u)local C=2*(v+A)local D=2*(w-z)local E=2*(v-A)local F=1-2*(s+u)local G=2
*(x+y)local H=2*(w+z)local I=2*(x-y)local J=1-2*(s+t)return constructor(k,l,m,B,
C,D,E,F,G,H,I,J)end local function toQuaternion(k)local l,m,n=k.r00,k.r01,k.r02
local o,p,q=k.r10,k.r11,k.r12 local r,s,t=k.r20,k.r21,k.r22 local u=l+p+t local
v,w,x,y if u>0 then local z=d(u+1)*2 v=0.25*z w=(s-q)/z x=(n-r)/z y=(o-m)/z
elseif l>p and l>t then local z=d(1+l-p-t)*2 v=(s-q)/z w=0.25*z x=(m+o)/z y=(n+r
)/z elseif p>t then local z=d(1+p-l-t)*2 v=(n-r)/z w=(m+o)/z x=0.25*z y=(q+s)/z
else local z=d(1+t-l-p)*2 v=(o-m)/z w=(n+r)/z x=(q+s)/z y=0.25*z end local z=d(w
*w+x*x+y*y+v*v)if z==0 then return 0,0,0,1 end return w/z,x/z,y/z,v/z end
local function slerp(k,l,m,n,o,p,q,r,s)local t=k*o+l*p+m*q+n*r if t<0 then o,p,q
,r=-o,-p,-q,-r t=-t end local u=1e-6 if t>1-u then local v=k+(o-k)*s local w=l+(
p-l)*s local x=m+(q-m)*s local y=n+(r-n)*s local z=d(v*v+w*w+x*x+y*y)return v/z,
w/z,x/z,y/z end local v=g(i(t,-1,1))local w=e(v)local x=v*s local y=e(x)local z=
f(x)-t*y/w local A=y/w local B=z*k+A*o local C=z*l+A*p local D=z*m+A*q local E=z
*n+A*r return B,C,D,E end local function matMul(k,l)return k.r00*l.r00+k.r01*l.
r10+k.r02*l.r20,k.r00*l.r01+k.r01*l.r11+k.r02*l.r21,k.r00*l.r02+k.r01*l.r12+k.
r02*l.r22,k.r10*l.r00+k.r11*l.r10+k.r12*l.r20,k.r10*l.r01+k.r11*l.r11+k.r12*l.
r21,k.r10*l.r02+k.r11*l.r12+k.r12*l.r22,k.r20*l.r00+k.r21*l.r10+k.r22*l.r20,k.
r20*l.r01+k.r21*l.r11+k.r22*l.r21,k.r20*l.r02+k.r21*l.r12+k.r22*l.r22 end
local function rotTranspose(k)return k.r00,k.r10,k.r20,k.r01,k.r11,k.r21,k.r02,k
.r12,k.r22 end local function rotateVec(k,l)return b.new(k.r00*l.x+k.r01*l.y+k.
r02*l.z,k.r10*l.x+k.r11*l.y+k.r12*l.z,k.r20*l.x+k.r21*l.y+k.r22*l.z)end
local function rotateVecT(k,l)return b.new(k.r00*l.x+k.r10*l.y+k.r20*l.z,k.r01*l
.x+k.r11*l.y+k.r21*l.z,k.r02*l.x+k.r12*l.y+k.r22*l.z)end local function
columnsFromEuler(k,l,m,n)n=string.upper(n or'XYZ')local o,p=f(k),e(k)local q,r=
f(l),e(l)local s,t=f(m),e(m)local function matXYZ()local u=q*s local v=o*t+p*r*s
local w=p*t-o*r*s local x=-q*t local y=o*s-p*r*t local z=p*s+o*r*t local A=r
local B=-p*q local C=o*q return u,v,w,x,y,z,A,B,C end local function matYXZ()
local u=q*s+r*p*t local v=o*t local w=q*p*t-r*s local x=r*s-q*p*t local y=o*s
local z=r*p*t+q*s local A=p*r local B=-p local C=o*q return u,v,w,x,y,z,A,B,C
end if n=='XYZ'then return matXYZ()elseif n=='YXZ'then return matYXZ()else
return matXYZ()end end j.new=function(...)local k=select('#',...)if k==0 then
return constructor(0,0,0)end local l=select(1,...)if k==1 and isVector3(l)then
return constructor(l.x,l.y,l.z)end if k==2 and isVector3(l)and isVector3(select(
2,...))then local m=l::any local n=select(2,...)::any return j.lookAt(m,n)end if
k==3 then local m,n,o=l,select(2,...),select(3,...)assert('number'==type(m)and
'number'==type(n)and'number'==type(o),`CFrame.new: expected numbers for x,y,z, got {
type(m)},{type(n)},{type(o)}`)return constructor(m,n,o)end if k==7 then local m,
n,o,p,q,r,s=l,select(2,...),select(3,...),select(4,...),select(5,...),select(6,
...),select(7,...)assert('number'==type(p)and'number'==type(q)and'number'==type(
r)and'number'==type(s),'CFrame.new: expected quaternion numbers')return
fromQuaternion(m,n,o,p,q,r,s)end if k==12 then local m,n,o,p,q,r,s,t,u,v,w,x=l,
select(2,...),select(3,...),select(4,...),select(5,...),select(6,...),select(7,
...),select(8,...),select(9,...),select(10,...),select(11,...),select(12,...)
return constructor(m,n,o,p,q,r,s,t,u,v,w,x)end return error
'CFrame.new: invalid arguments'end function j.lookAt(k,l,m)assert(isVector3(k),`CFrame.lookAt: expected Vector3 for 1st argument, got {
type(k)}`)assert(isVector3(l),`CFrame.lookAt: expected Vector3 for 2nd argument, got {
type(l)}`)m=(m and assert(isVector3(m),`CFrame.lookAt: expected Vector3 for 3rd argument, got {
type(m)}`)and m)or b.yAxis local n=(l-k).unit if n.magnitude==0 then return
constructor(k.x,k.y,k.z)end local o=m:cross(n).unit if o.magnitude==0 then local
p=c(n.y)<0.999 and b.yAxis or b.xAxis o=p:cross(n).unit end local p=n:cross(o).
unit local q=(o:cross(p))q=n*-1 return constructor(k.x,k.y,k.z,o.x,p.x,q.x,o.y,p
.y,q.y,o.z,p.z,q.z)end function j.lookAlong(k,l,m)assert(isVector3(k),`CFrame.lookAlong: expected Vector3 for 1st argument, got {
type(k)}`)assert(isVector3(l),`CFrame.lookAlong: expected Vector3 for 2nd argument, got {
type(l)}`)return j.lookAt(k,k+l,m)end function j.fromRotationBetweenVectors(k,l)
assert(isVector3(k),`CFrame.fromRotationBetweenVectors: expected Vector3 for 1st argument, got {
type(k)}`)assert(isVector3(l),`CFrame.fromRotationBetweenVectors: expected Vector3 for 2nd argument, got {
type(l)}`)local m=k.unit local n=l.unit if m.magnitude==0 or n.magnitude==0 then
return constructor(0,0,0)end local o=i(m:dot(n),-1,1)if o>0.99999999 then return
constructor(0,0,0)elseif o<-0.99999999 then local p=(c(m.x)<0.9 and b.xAxis or b
.yAxis):cross(m).unit return j.fromAxisAngle(p,math.pi)else local p=m:cross(n).
unit local q=g(o)return j.fromAxisAngle(p,q)end end function j.fromEulerAngles(k
,l,m,n)local o,p,q,r,s,t,u,v,w=columnsFromEuler(k,l,m,n)return constructor(0,0,0
,o,p,q,r,s,t,u,v,w)end function j.fromEulerAnglesXYZ(k,l,m)return j.
fromEulerAngles(k,l,m,'XYZ')end function j.fromEulerAnglesYXZ(k,l,m)return j.
fromEulerAngles(k,l,m,'YXZ')end function j.Angles(k,l,m)return j.
fromEulerAnglesXYZ(k,l,m)end function j.fromOrientation(k,l,m)return j.
fromEulerAnglesYXZ(k,l,m)end function j.fromAxisAngle(k,l)assert(isVector3(k),`CFrame.fromAxisAngle: expected Vector3 for axis, got {
type(k)}`)assert('number'==type(l),`CFrame.fromAxisAngle: expected number for angle, got {
type(l)}`)local m=k.unit local n,o,p=m.x,m.y,m.z local q,r,s=f(l),e(l),1-f(l)
local t=s*n*n+q local u=s*n*o+r*p local v=s*n*p-r*o local w=s*n*o-r*p local x=s*
o*o+q local y=s*o*p+r*n local z=s*n*p+r*o local A=s*o*p-r*n local B=s*p*p+q
return constructor(0,0,0,t,u,v,w,x,y,z,A,B)end function j.fromMatrix(k,l,m,n)
assert(isVector3(k),`CFrame.fromMatrix: expected Vector3 for pos, got {type(k)}`
)assert(isVector3(l),`CFrame.fromMatrix: expected Vector3 for vX, got {type(l)}`
)assert(isVector3(m),`CFrame.fromMatrix: expected Vector3 for vY, got {type(m)}`
)if nil~=n then assert(isVector3(n),`CFrame.fromMatrix: expected Vector3 for vZ, got {
type(n)}`)end local o=l local p=m local q=n or o:cross(p).unit return
constructor(k.x,k.y,k.z,o.x,p.x,q.x,o.y,p.y,q.y,o.z,p.z,q.z)end function j.
inverse(k)local l,m,n,o,p,q,r,s,t=rotTranspose(k)local u=b.new(k.x,k.y,k.z)local
v=b.new(-(l*u.x+m*u.y+n*u.z),-(o*u.x+p*u.y+q*u.z),-(r*u.x+s*u.y+t*u.z))return
constructor(v.x,v.y,v.z,l,m,n,o,p,q,r,s,t)end function j.lerp(k,l,m:number)
assert(isCFrame(l),`CFrame.lerp: expected a CFrame, got {type(l)}`)assert(
'number'==type(m),`CFrame.lerp: expected a number for alpha, got {type(m)}`)
local n=k.x+(l.x-k.x)*m local o=k.y+(l.y-k.y)*m local p=k.z+(l.z-k.z)*m local q,
r,s,t=toQuaternion(k)local u,v,w,x=toQuaternion(l)local y,z,A,B=slerp(q,r,s,t,u,
v,w,x,m)return fromQuaternion(n,o,p,y,z,A,B)end function j.orthonormalize(k)
local l=b.new(k.r00,k.r10,k.r20).unit local m=b.new(k.r01,k.r11,k.r21)m=(m-l*l:
dot(m)).unit local n=l:cross(m)return constructor(k.x,k.y,k.z,l.x,m.x,n.x,l.y,m.
y,n.y,l.z,m.z,n.z)end function j.toworldspace(k,...)local l=table.pack(...)for m
=1,l.n do assert(isCFrame(l[m]),`CFrame.toworldspace: expected CFrame, got {
type(l[m])}`)l[m]=k*l[m]end return table.unpack(l,1,l.n)end function j.
toobjectspace(k,...)local l=k:inverse()local m=table.pack(...)for n=1,m.n do
assert(isCFrame(m[n]),`CFrame.toobjectspace: expected CFrame, got {type(m[n])}`)
m[n]=l*m[n]end return table.unpack(m,1,m.n)end function j.pointtoworldspace(k,
...)local l=table.pack(...)for m=1,l.n do assert(isVector3(l[m]),`CFrame.pointtoworldspace: expected Vector3, got {
type(l[m])}`)local n:any=l[m]l[m]=b.new(k.x,k.y,k.z)+rotateVec(k,n)end return
table.unpack(l,1,l.n)end function j.pointtoobjectspace(k,...)local l=table.pack(
...)for m=1,l.n do assert(isVector3(l[m]),`CFrame.pointtoobjectspace: expected Vector3, got {
type(l[m])}`)local n:any=l[m]local o=n-b.new(k.x,k.y,k.z)l[m]=rotateVecT(k,o)end
return table.unpack(l,1,l.n)end function j.vectortoworldspace(k,...)local l=
table.pack(...)for m=1,l.n do assert(isVector3(l[m]),`CFrame.vectortoworldspace: expected Vector3, got {
type(l[m])}`)l[m]=rotateVec(k,l[m])end return table.unpack(l,1,l.n)end function
j.vectortoobjectspace(k,...)local l=table.pack(...)for m=1,l.n do assert(
isVector3(l[m]),`CFrame.vectortoobjectspace: expected Vector3, got {type(l[m])}`
)l[m]=rotateVecT(k,l[m])end return table.unpack(l,1,l.n)end function j.
getcomponents(k)return k.x,k.y,k.z,k.r00,k.r01,k.r02,k.r10,k.r11,k.r12,k.r20,k.
r21,k.r22 end function j.toeulerangles(k,l)l=string.upper(l or'XYZ')local m,n,o=
k.r00,k.r01,k.r02 local p,q,r=k.r10,k.r11,k.r12 local s,t,u=k.r20,k.r21,k.r22 if
l=='XYZ'then local v=s local w,x,y if c(v)<0.999999 then w=h(-t,u)x=h(v,d(1-v*v)
)y=h(-p,m)else w=h(q,r)x=h(v,d(1-v*v))y=0 end return w,x,y elseif l=='YXZ'then
local v=-t local w,x,y if c(v)<0.999999 then x=h(s,u)w=h(v,d(1-v*v))y=h(n,q)else
x=h(-o,m)w=h(v,d(1-v*v))y=0 end return w,x,y else return j.fromEulerAnglesXYZ(0,
0,0):toeulerangles'XYZ'end end function j.toeuleranglesxyz(k)return k:
toeulerangles'XYZ'end function j.toeuleranglesyxz(k)return k:toeulerangles'YXZ'
end function j.toorientation(k)return k:toeulerangles'YXZ'end function j.
toaxisangle(k)local l,m,n,o=toQuaternion(k)local p=2*g(i(o,-1,1))local q=d(1-o*o
)if q<1e-6 then return b.xAxis,0 end return b.new(l/q,m/q,n/q),p end function j.
fuzzyeq(k,l,m:number?)assert(isCFrame(l),`CFrame.fuzzyeq: expected a CFrame, got {
type(l)}`)assert('number'==type(m)or'nil'==type(m),`CFrame.fuzzyeq: expected a number for epsilon, got {
type(m)}`)m=m or 1e-5 if c(k.x-l.x)>m or c(k.y-l.y)>m or c(k.z-l.z)>m then
return false end return k:anglebetween(l)<=m end function j.anglebetween(k,l)
assert(isCFrame(l),`CFrame.anglebetween: expected a CFrame, got {type(l)}`)local
m,n,o,p,q,r,s,t,u=matMul({r00=k.r00,r01=k.r01,r02=k.r02,r10=k.r10,r11=k.r11,r12=
k.r12,r20=k.r20,r21=k.r21,r22=k.r22},{r00=l.r00,r01=l.r01,r02=l.r02,r10=l.r10,
r11=l.r11,r12=l.r12,r20=l.r20,r21=l.r21,r22=l.r22})return g(i((m+q+u-1)*0.5,-1,1
))end j.identity=constructor(0,0,0)j.__metatable='CFrame'function j.__mul(k,l)if
isVector3(l)then local m=l::any return b.new(k.x+k.r00*m.x+k.r01*m.y+k.r02*m.z,k
.y+k.r10*m.x+k.r11*m.y+k.r12*m.z,k.z+k.r20*m.x+k.r21*m.y+k.r22*m.z)end assert(
isCFrame(l),`CFrame.__mul: expected CFrame or Vector3, got {type(l)}`)local m,n,
o,p,q,r,s,t,u=matMul(k,l)local v=b.new(k.x+k.r00*l.x+k.r01*l.y+k.r02*l.z,k.y+k.
r10*l.x+k.r11*l.y+k.r12*l.z,k.z+k.r20*l.x+k.r21*l.y+k.r22*l.z)return
constructor(v.x,v.y,v.z,m,n,o,p,q,r,s,t,u)end function j.__add(k,l)assert(
isVector3(l),`CFrame.__add: expected a Vector3, got {type(l)}`)return
constructor(k.x+l.x,k.y+l.y,k.z+l.z,k.r00,k.r01,k.r02,k.r10,k.r11,k.r12,k.r20,k.
r21,k.r22)end function j.__sub(k,l)assert(isVector3(l),`CFrame.__sub: expected a Vector3, got {
type(l)}`)return constructor(k.x-l.x,k.y-l.y,k.z-l.z,k.r00,k.r01,k.r02,k.r10,k.
r11,k.r12,k.r20,k.r21,k.r22)end function j.__index(k,l)l=string.lower(l)if
'position'==l then return b.new(k.x,k.y,k.z)end if'rotation'==l then return
constructor(0,0,0,k.r00,k.r01,k.r02,k.r10,k.r11,k.r12,k.r20,k.r21,k.r22)end if
'x'==l then return k.x end if'y'==l then return k.y end if'z'==l then return k.z
end if'xvector'==l or'rightvector'==l then return b.new(k.r00,k.r10,k.r20)end if
'yvector'==l or'upvector'==l then return b.new(k.r01,k.r11,k.r21)end if'zvector'
==l then return b.new(k.r02,k.r12,k.r22)end if'lookvector'==l then return b.new(
k.r02,k.r12,k.r22)*-1 end return rawget(j,l)or k[l]end function j.__tostring(k)
return`({k.x}, {k.y}, {k.z}, {k.r00}, {k.r01}, {k.r02}, {k.r10}, {k.r11}, {k.r12
}, {k.r20}, {k.r21}, {k.r22})`end end return table.freeze(j)end function a.i()a.
load'e'a.load'c'local b=a.load'f'local c=a.load'g'local d=a.load'h'_G.Vector3=b
_G.Vector2=c _G.CFrame=d return table.freeze{Vector3=b,Vector2=c,CFrame=d}end
end _G.Signal=a.load'a'_G.websocket=a.load'b'_G.json=a.load'c'_G.http=a.load'd'
_G.print=function(...)local b,c={...},select('#',...)local d=''for e=1,c do
local f=b[e]if type(f)=='table'then if f.Name and f.Data then d=d..f.Name..' | '
end elseif type(f)=='userdata'then d=d..getname(f)..' | 'end local g=tostring(f)
if type(g)~='string'then error"'tostring' must return a string - print function"
end d=d..g..' 'end return print(d)end _G.warn=function(...)local b,c={...},
select('#',...)local d=''for e=1,c do local f=b[e]if type(f)=='table'then if f.
Name and f.Data then d=d..f.Name..' | 'end elseif type(f)=='userdata'then d=d..
getname(f)..' | 'end local g=tostring(f)if type(g)~='string'then error
"'tostring' must return a string - warn function"end d=d..g..' 'end return warn(
d)end return a.load'i'