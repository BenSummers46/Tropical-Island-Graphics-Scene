using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    public float flyspeed = 0.5f;
    public float acceleration = 3f;
    public float accelRatio = 1;
    public float slowDown = 0.5f;

    float changeX;
    float changeY;

    float yMax = 90f;
    float yMin = -90f;

    [SerializeField] float sensitivity;

    
    
    // Start is called before the first frame update
    void Start()
    {
        Vector3 rotateChange = transform.rotation.eulerAngles;
        changeX = rotateChange.x;
        changeY = rotateChange.y;

        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
    }

    // Update is called once per frame
    void Update()
    {
        changeX += Input.GetAxisRaw("Mouse X") * (sensitivity * Time.deltaTime);
        changeY += -Input.GetAxisRaw("Mouse Y") * (sensitivity * Time.deltaTime);

        changeY = Mathf.Clamp(changeY, yMin, yMax);

        transform.rotation = Quaternion.Euler(changeY, changeX, 0f);

        Vector3 movement = new Vector3(Input.GetAxisRaw("Horizontal"), 0, Input.GetAxisRaw("Vertical"));

        if (Input.GetKey(KeyCode.LeftShift))
        {
            transform.Translate(movement * 0.3f);
        }else if (Input.GetKey(KeyCode.LeftControl))
        {
            transform.Translate(movement * 0.1f);
        }
        else
        {
            transform.Translate(movement * 0.1f);
        }

        if (Input.GetKey(KeyCode.Space))
        {
            transform.Translate(transform.up);
        }else if (Input.GetKey(KeyCode.LeftAlt))
        {
            transform.Translate(-transform.up);
        }

        
    }
}
