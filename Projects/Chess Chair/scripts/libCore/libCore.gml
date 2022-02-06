//#macro core		__controlInstance()

//function __coreInstance()
//{
//	static data = 
//	{
//		co: __controlInstance(),
//		cm: __cameraInstance(),
//		in: __inputInstance(),
//		sl: __saveInstance(),
//		fx: __fxInstance(),
//		pt: __particleInstance(),
//		rm: __roomInstance()
//	}
//	return data;
//}


//function instance_create_static(_instance)
//{
//	static instance = _instance;
//	return instance;
//}

//function __controlInstance()
//{
//	static instance = instance_create_layer(0, 0, "Game", Core);
//	return instance;
//}
//function __cameraInstance()
//{
//	static instance = instance_create_layer(0, 0, "Game", objCamera);
//	return instance;
//}
//function __inputInstance()
//{
//	static instance = instance_create_layer(0, 0, "Game", objInputManager);
//	return instance;
//}
//function __saveInstance()
//{
//	static instance = instance_create_layer(0, 0, "Game", objSaveManager);
//	return instance;
//}
//function __fxInstance()
//{
//	static instance = instance_create_layer(0, 0, "Game", objFxManager);
//	return instance;
//}
//function __particleInstance()
//{
//	static instance = instance_create_layer(0, 0, "Game", objParticleManager);
//	return instance;
//}
//function __roomInstance()
//{
//	static instance = instance_create_layer(0, 0, "Game", objRoomManager);
//	return instance;
//}