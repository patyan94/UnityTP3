using UnityEngine;

[RequireComponent(typeof(CarController))]
public class CarUserControl : MonoBehaviour
{
    private CarController car;  // the car controller we want to use
	private bool jumpActive;

    void Awake ()
    {
        // get the car controller
        car = GetComponent<CarController>();
    }


    void FixedUpdate()
    {
		jumpActive = Input.GetKey(KeyCode.Space);
		bool nitro = Input.GetKeyDown (KeyCode.LeftShift);
        // pass the input to the car!
#if CROSS_PLATFORM_INPUT
		float h = CrossPlatformInput.GetAxis("Horizontal");
		float v = CrossPlatformInput.GetAxis("Vertical");
		//jumpActive = CrossPlatformInput.GetButton("Jump");
#else
		float h = Input.GetAxis("Horizontal");
		float v = Input.GetAxis("Vertical");

#endif
        car.Move(h,v, jumpActive, nitro);
    }
}
