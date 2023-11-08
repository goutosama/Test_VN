shader_type spatial;
render_mode unshaded;

//struct appdata
//{
//    vector4 vertex = POSITION;
//    vector2 uv = UV;
//}

//struct v2f
//{
//    vector4 pos = POSITION;
//    vector2 uv = UV;
//}

uniform sampler2D _MainTex;
uniform vec4 _MainTex_ST;

float rayPlaneIntersection(vec3 rayDir, vec3 rayPos, vec3 planeNormal, vec3 planePos)
{
    float denom = dot(planeNormal, rayDir);
    denom = max(denom, 0.000001); // avoid divide by zero
    vec3 diff = planePos - rayPos;
    return dot(diff, planeNormal) / denom;
}

void vertex()
{
    POSITION = PROJECTION_MATRIX * POSITION;
    UV = UV.xy;

    // billboard mesh towards camera
    vec3 vpos = WORLD_MATRIX * POSITION.xyz;
    vec4 worldCoord = WORLD_MATRIX[3].xyz;
    vec4 viewPos = INV_CAMERA_MATRIX * worldCoord + vec4(vpos, 0);

    POSITION = UNITY_MATRIX_P * viewPos;

    // calculate distance to vertical billboard plane seen at this vertex's screen position
    vec3 planeNormal = normalize(float3(UNITY_MATRIX_V._m20, 0.0, UNITY_MATRIX_V._m22));
    vec3 planePoint = unity_ObjectToWorld._m03_m13_m23;
    vec3 rayStart = _WorldSpaceCameraPos.xyz;
    vec3 rayDir = -normalize(mul(UNITY_MATRIX_I_V, float4(viewPos.xyz, 1.0)).xyz - rayStart); // convert view to world, minus camera pos
    float dist = rayPlaneIntersection(rayDir, rayStart, planeNormal, planePoint);

    // calculate the clip space z for vertical plane
    vec4 planeOutPos = mul(UNITY_MATRIX_VP, float4(rayStart + rayDir * dist, 1.0));
    float newPosZ = planeOutPos.z / planeOutPos.w * o.pos.w;

    // use the closest clip space z
    if (defined(UNITY_REVERSED_Z)){
        POSITION.z = max(POSITION.z, newPosZ);
    } else{
        POSITION.z = min(POSITION.z, newPosZ);
    }
}

void fragment()
{
    ALBEDO = tex2D(_MainTex, UV);
}