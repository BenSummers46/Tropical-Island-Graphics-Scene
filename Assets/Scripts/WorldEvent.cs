using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WorldEvent : MonoBehaviour
{
    [SerializeField] GameObject centreRock;
    
    private void FixedUpdate()
    {
        if (Input.GetKey(KeyCode.Q))
        {
            if(centreRock.transform.position.y > -6)
            {
                return;
            }
            else
            {
                centreRock.transform.Translate(0, 0.1f, 0, Space.World);
            }
        }
    }
}
