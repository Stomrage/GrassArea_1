/*
* vertex shader template
*/

uniform vec4 g_LightPosition;
uniform vec4 g_LightColor;
uniform vec4 g_LightDirection;
uniform mat4 g_ViewProjectionMatrix;

vec3 toDirection(vec4 direction){
    return vec3(direction.x, direction.y, direction.z);
}

void main(){ 

    bool toDo = true;
    vec4 modelSpacePos = vec4(modelPosition,1.0);
    vec3 cameraOffset = (cameraPosition - modelPosition);
    /*if(cameraPosition.z - modelPosition.z > 0){
        if((cameraPosition.x - modelPosition.x < texCoord2.y && cameraPosition.x - modelPosition.x > -texCoord2.y)){
            toDo = false;        
        }
    }else{
        if((cameraPosition.x - modelPosition.x > texCoord2.y && cameraPosition.x - modelPosition.x < -texCoord2.y)){
            toDo = false;        
        }
    }*/

    camDist = length(vec2(cameraOffset.x,cameraOffset.z));

    /*if(texCoord2.y > 0 && cameraOffset.x > 0 && toDo){        
        vec3 toAdd = vec3(0,0,0);
        cameraOffset = normalize(cameraOffset);
        float angle = atan(cameraOffset.z, cameraOffset.x); 
        toAdd.z += -cos(angle) * abs(texCoord2.y);
        toAdd.x += sin(angle) * abs(texCoord2.y);
        toAdd.x += abs(texCoord2.y);
        modelSpacePos.xyz += toAdd/2;
    }
    if(texCoord2.y > 0 && cameraOffset.x < 0 && toDo){
        vec3 toAdd = vec3(0,0,0);
        cameraOffset = normalize(cameraOffset);
        float angle = atan(cameraOffset.z, cameraOffset.x);
        toAdd.z += -cos(angle) * abs(texCoord2.y);
        toAdd.x += sin(angle) * abs(texCoord2.y);
        toAdd.x += -abs(texCoord2.y);
        modelSpacePos.xyz += -toAdd/2;
    }
    if(texCoord2.y < 0 && cameraOffset.x > 0 && toDo){
        vec3 toAdd = vec3(0,0,0);
        cameraOffset = normalize(cameraOffset);
        float angle = atan(cameraOffset.z, cameraOffset.x);   
        toAdd.z += -cos(angle) * abs(texCoord2.y);
        toAdd.x += sin(angle) * abs(texCoord2.y);
        toAdd.x += abs(texCoord2.y);
        modelSpacePos.xyz += -toAdd/2;
    }
    if(texCoord2.y < 0 && cameraOffset.x < 0 && toDo){
        vec3 toAdd = vec3(0,0,0);
        cameraOffset = normalize(cameraOffset);
        float angle = atan(cameraOffset.z, cameraOffset.x);
        toAdd.z += sign(texCoord2.y)*cos(angle) * abs(texCoord2.y);
        toAdd.x += sin(angle) * abs(texCoord2.y);
        toAdd.x += -abs(texCoord2.y);
        modelSpacePos.xyz += toAdd/2;
    }*/
    if(cameraPosition.z - modelPosition.z > 0){
        if((cameraPosition.x - modelPosition.x < texCoord2.y && cameraPosition.x - modelPosition.x > -texCoord2.y)){
            toDo = false;        
        }
    }else{
        if((cameraPosition.x - modelPosition.x > texCoord2.y && cameraPosition.x - modelPosition.x < -texCoord2.y)){
            toDo = false;        
        }
    }

    if(toDo){
        vec3 toAdd = vec3(0,0,0);
        cameraOffset = normalize(cameraOffset);
        float angle = atan(cameraOffset.z, cameraOffset.x);
        toAdd.z += -cos(angle) * abs(texCoord2.y);
        toAdd.x += sin(angle) * abs(texCoord2.y);
        toAdd.x += sign(cameraOffset.x)*abs(texCoord2.y);
        modelSpacePos.xyz += sign(cameraOffset.x)*sign(texCoord2.y)*toAdd/2;
    }
    projPosition = projectionMatrix * viewMatrix * modelSpacePos;

    vec4 worldPos = worldMatrix*vec4(modelPosition,1.0);
    vec3 diffLight = vec3(0.0,0.0,0.0);
    float posLight = step(0.5, g_LightColor.w);
    vec3 lightVec = g_LightPosition.xyz * sign(posLight - 0.5) - (worldPos.xyz * posLight);
    float lDist = length(lightVec);
    float att = clamp(1.0 - g_LightPosition.w * lDist * posLight, 0.0, 1.0);
    lightVec = lightVec / vec3(lDist);
    diffuseLight = g_LightColor.rgb*(att);

    colorToMix = texCoord2.x;
    minX = texCoord3.x;
    texSize = texCoord3.y;
    texCoord1.x = texCoord1.x*texSize+minX;

}
