using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(CarController))]
public class CarUserControlMP : MonoBehaviour
{
	private CarController car;  // the car controller we want to use

    public UpdateLookAt DirectionHelp;
    public void UpdateDirectionHelp(Transform target)
    {
        DirectionHelp.SetTarget(target);
    }

    [SerializeField]
	private string vertical = "Vertical";

	[SerializeField]
	private string horizontal = "Horizontal";

	[SerializeField]
	int joueur;

	public Slider nitroBar;
	float elapsedTime = 0.0f;
	[SerializeField]
	float nitroChargeTimePeriod = 0.1f;
	[SerializeField]
	float nitroCharge = 0.5f;
	[SerializeField]
	float nitroConsumption = 1.0f;
	
	public float fireRate = 1.0f;
	private float nextFire = 0.0f;
	private int shootCount = 0;
	
	void Awake ()
	{
		// get the car controller
		car = GetComponent<CarController>();
		nitroBar.maxValue = 100;
		nitroBar.minValue = 0;
		nitroBar.value = 0;
	}

	void Update(){
		elapsedTime += Time.deltaTime;
		if (elapsedTime >= nitroChargeTimePeriod) {
			nitroBar.value += nitroCharge ;
			elapsedTime = 0.0f;
		}
	}

	void FixedUpdate()
	{
		bool jumpActive = (Input.GetButtonDown("Jump") && joueur == 1) || (Input.GetButtonDown("Jump2") && joueur == 2);
		bool nitro = (Input.GetKey(KeyCode.LeftShift) && joueur == 1) || (Input.GetKey(KeyCode.RightShift) && joueur == 2);

		if (nitro) {
			nitroBar.value -= nitroConsumption;
		}

		// pass the input to the car!
		#if CROSS_PLATFORM_INPUT
		float h = CrossPlatformInput.GetAxis(horizontal);
		float v = CrossPlatformInput.GetAxis(vertical);
		bool f = (Input.GetButtonDown("Fire1") && joueur == 1) || (Input.GetButtonDown("Fire2") && joueur == 2);
		#else
		float h = Input.GetAxis(horizontal);
		float v = Input.GetAxis(vertical);
		bool f = Input.GetButton("Fire1");
		#endif
		car.Move(h,v, jumpActive, nitro);
		if (Time.time > nextFire && f) {
			car.Shoot (f);
			shootCount++;
			//Debug.Log("Shoot Count : " + shootCount.ToString());
			nextFire = Time.time + fireRate;
			f = false;
		}
	}
}
