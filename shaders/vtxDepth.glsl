#version 330

layout(location=0) in vec3 coord;  
 
uniform mat4 A; 

void main() {
    gl_Position = A*vec4(coord, 1.0);
} 
