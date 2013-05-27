# 编译.proto生成对文件到对应文件夹

currentDir=$(cd "$(dirname "$0")"; pwd)
cd $currentDir


protoFileDir="../../../../../together-server/src/data"

networkDir="../../Network"

dataFormatDir="DataFormat"
responseDir="ResponseData"


#接口返回格式
src/protoc --proto_path=$protoFileDir --objc_out=$networkDir $protoFileDir"/Response.proto" 

#列表
src/protoc --proto_path=$protoFileDir --objc_out=$networkDir $protoFileDir"/data.proto"


#用户模块
src/protoc --proto_path=$protoFileDir --objc_out=$networkDir"/User/"$responseDir $protoFileDir"/UserResponse.proto"
src/protoc --proto_path=$protoFileDir --objc_out=$networkDir"/User/"$dataFormatDir $protoFileDir"/UserData.proto"


#房间模块
src/protoc --proto_path=$protoFileDir --objc_out=$networkDir"/Room/"$responseDir $protoFileDir"/RoomResponse.proto"
src/protoc --proto_path=$protoFileDir --objc_out=$networkDir"/Room/"$dataFormatDir $protoFileDir"/RoomData.proto"

#消息
src/protoc --proto_path=$protoFileDir --objc_out=$networkDir"/Message/"$dataFormatDir $protoFileDir"/MessageData.proto"


exit 0