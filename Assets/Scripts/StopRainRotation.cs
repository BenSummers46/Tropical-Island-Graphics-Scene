using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StopRainRotation : MonoBehaviour
{
    Quaternion initRotation;
    
    // Start is called before the first frame update
    void Start()
    {
        initRotation = transform.rotation;
    }

    // Update is called once per frame
    void LateUpdate()
    {
        transform.rotation = initRotation;
    }
}
