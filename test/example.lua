local Ball = { Camera = {} }
local Mouse = { State = nil, Left = false, Right = false }
local State = { Move = 0, Strafe = 0, SpeedMultiplier = 1 }
local Settings = { Speed = 10, MouseRotation = 0.25, MaximumPitch = Degree.new( 85 ), MinimumPitch = Degree.new( -85 ) }
Vector3.Zero = Vector3.new( 0, 0, 0 );

function Create()
  Script.MousePriority = -1;
  Script.KeyboardPriority = -1;
  
  -- Create player object
  Ball.Object = ObjectManager:CreateObject( "PlayerBall", "Local" );
  Ball.Object.Position = Vector3.new( 0, 10, 0 );
  -- Mesh
  Ball.Mesh = Ball.Object:CreateComponent( ComponentType.Mesh, "Mesh", false );
  Ball.Mesh.ShapeType = "Sphere";
  Ball.Mesh.ShapeUV = Vector2.new( 1, 2 );
  Ball.Mesh.ShapeXSegments = 40;
  Ball.Mesh.ShapeRadius = 0.3;
  -- Entity
  Ball.Entity = Ball.Object:CreateComponent( ComponentType.Entity, "Entity", false );
  Ball.Entity.Material = "Ball";
  -- Light
  Ball.Light = Ball.Object:CreateComponent( ComponentType.Light, "Light", false );
  Ball.Light.Type = LightType.Spot;
  
  -- CollisionShape
  Ball.CollisionShape = Ball.Object:CreateComponent( ComponentType.CollisionShape, "CollisionShape", false );
  Ball.CollisionShape.ShapeType = "Sphere";
  Ball.CollisionShape.ShapeParameters = Vector3.new( 0.3, 1, 1 );
  -- RigidBody
  Ball.RigidBody = Ball.Object:CreateComponent( ComponentType.RigidBody, "RigidBody", false );
  Ball.RigidBody.PhysicsType = PhysicsType.Dynamic;
  Ball.RigidBody.Restitution = 0.3;
  Ball.RigidBody.LinearDampening = 0.7;
  Ball.RigidBody.AngularDampening = 0.7;

  -- Camera yaw object
  Ball.Camera.YawObject = ObjectManager:CreateObject( "PlayerBallCameraYaw", "Local" );
  Ball.Camera.YawObject.Position = Vector3.new( 0, 0.5, 0 );
  -- Camera pitch object
  Ball.Camera.PitchObject = Ball.Camera.YawObject:CreateChildObject( "PlayerBallCameraPitch" );
  -- Camera object
  Ball.Camera.Object = Ball.Camera.PitchObject:CreateChildObject( "PlayerBallCamera" );
  Ball.Camera.Object.Position = Vector3.new( 0, 0, 5 );
  -- Camera
  Ball.Camera.Camera = Ball.Camera.Object:CreateComponent( ComponentType.Camera, "Camera", false );
  Ball.Camera.Camera.Active = true;
end

function Destroy()
  if ObjectManager:HasObject( "PlayerBall" ) then ObjectManager:DestroyObjectTree( "PlayerBall" ); end
  if ObjectManager:HasObject( "PlayerBallCameraYaw" ) then ObjectManager:DestroyObjectTree( "PlayerBallCameraYaw" ); end
  
  Ball = nil;
  Mouse = nil;
  State = nil;
end

function Frame( TimeSinceLastFrame )
  -- Cap values
  if State.Move < -1 then State.Move = -1; end
  if State.Move > 1 then State.Move = 1; end
  if State.Strafe < -1 then State.Strafe = -1; end
  if State.Strafe > 1 then State.Strafe = 1; end
  
  -- Ball
  -- Move
  if State.Move ~= 0 then
    Ball.RigidBody:ApplyCentralForce( Ball.Camera.YawObject.DerivedOrientation * Vector3.new( 0, 0, Settings.Speed * -State.Move * State.SpeedMultiplier ) );
  end
  
  -- Strafe
  if State.Strafe ~= 0 then
    Ball.RigidBody:ApplyCentralForce( Ball.Camera.YawObject.DerivedOrientation * Vector3.new( Settings.Speed * -State.Strafe * State.SpeedMultiplier, 0, 0 ) );
  end
  
  -- Camera
  if Mouse.Right then
    -- Yaw
    Ball.Camera.YawObject:Yaw( Radian.new( Degree.new( -Mouse.State.X.Relative * Settings.MouseRotation ) ), "Local" );
    
    -- Pitch
    local Pitch = Ball.Camera.PitchObject.Orientation.Pitch;
    local DegreeChange = Degree.new( -Mouse.State.Y.Relative * Settings.MouseRotation );
    local NewPitch = DegreeChange + Pitch;
    if NewPitch < Settings.MaximumPitch and NewPitch > Settings.MinimumPitch then
      Ball.Camera.PitchObject:Pitch( Radian.new( DegreeChange ), "Local" );
    end
  end
  
  if Mouse.State then 
    -- Distance
    local Distance = Ball.Camera.Object.Position.Z;
    if Mouse.State.Z.Relative > 0 then
      Distance = Distance - Distance / 12;
      if Distance < 5 then Distance = 5; end -- Minimum distance
    elseif Mouse.State.Z.Relative < 0 then
      Distance = Distance + Distance / 12;
      if Distance > 50 then Distance = 50; end -- Maximum distance
    end
    Ball.Camera.Object.Position = Vector3.new( 0, 0, Distance );
  
    -- Clear mouse state
    Mouse.State:Clear(); 
  end
end

function LateUpdate()
  Ball.Camera.YawObject.Position = Ball.Object.Position;
end

function KeyPressed( Key )
  if Key == KeyboardButton.W then 
    State.Move = State.Move + 1;
  elseif Key == KeyboardButton.S then 
    State.Move = State.Move - 1;
  elseif Key == KeyboardButton.A then 
    State.Strafe = State.Strafe + 1;
  elseif Key == KeyboardButton.D then 
    State.Strafe = State.Strafe - 1; 
  elseif Key == KeyboardButton.Shift then
    State.SpeedMultiplier = 20;
  end
end

function KeyReleased( Key )
  if Key == KeyboardButton.W then 
    State.Move = State.Move - 1;
  elseif Key == KeyboardButton.S then 
    State.Move = State.Move + 1;
  elseif Key == KeyboardButton.A then 
    State.Strafe = State.Strafe - 1;
  elseif Key == KeyboardButton.D then 
    State.Strafe = State.Strafe + 1;
  elseif Key == KeyboardButton.Shift then
    State.SpeedMultiplier = 1;
  end
end

function MousePressed( Button )
  if Button == MouseButton.Left then 
    Mouse.Left = true;
  elseif Button == MouseButton.Right then 
    Mouse.Right = true; 
  end
end

function MouseReleased( Button )
  if Button == MouseButton.Left then 
    Mouse.Left = false;
  elseif Button == MouseButton.Right then 
    Mouse.Right = false; 
  end
end

function MouseMoved( NewMouseState )
  Mouse.State = MouseState.new( NewMouseState );
end