using UnityEngine;
using System.Collections;

public class SmartProjectileBehaviour : MonoBehaviour
{

	public enum ProjectileType
	{
		RED = 0,
		BLUE,
		GREEN
	}
	;
	
	bool m_shoot = false;
	Vector3 m_direction;
	public float speed = 100f;
	public ProjectileType proType;
	public float damage = 35.0f;
	public GameObject targetPicker;
	public GameObject explosion;
	private NavMeshAgent agent;
	private Color c = Color.red;
	private GameObject gameManager;
	private GameObject targetCar;
	private CarController parentCar;
	private GameObject track;
	
	// Use this for initialization
	void Start ()
	{
		agent = gameObject.GetComponent<NavMeshAgent> ();
		agent.speed = speed;

		gameManager = GameObject.FindGameObjectWithTag ("GameManager");
		track = GameObject.FindGameObjectWithTag ("Track");
		Physics.IgnoreCollision (track.GetComponent<Collider> (), GetComponent<Collider> ());
	}
	
	// Update is called once per frame
	void FixedUpdate ()
	{

		if (m_shoot) {
			agent.SetDestination (targetCar.transform.position);
			
			DrawPath ();
		}

	}

	void DrawPath ()
	{

		NavMeshPath path = agent.path;
		
		Vector3 previousCorner = path.corners [0];
		
		int i = 1;
		while (i < path.corners.Length) {
			Vector3 currentCorner = path.corners [i];
			Debug.DrawLine (previousCorner, currentCorner, c);
			previousCorner = currentCorner;
			i++;
		}
	}

	void OnTriggerEnter (Collider other)
	{

		CarController car = other.transform.GetComponentInParent<CarController> ();
		if (car) {

			GameObject tempExplosion = Instantiate (explosion, transform.position, Quaternion.identity) as GameObject;
			car.SendMessage ("receiveDamage", damage);
			handleProjetctileDestruction(car);

		} else if (other.transform.parent.tag == "Wall" || other.transform.parent.tag == "Obstacles") {

			GameObject tempExplosion = Instantiate (explosion, transform.position, Quaternion.identity) as GameObject;
			handleProjetctileDestruction(car);
		}

	}

	void handleProjetctileDestruction(CarController car){

		if (proType == ProjectileType.RED)
			Destroy (this);

		else if (proType == ProjectileType.BLUE) {
			if (car.gameObject.GetInstanceID () == targetCar.GetInstanceID ()) {
				Destroy (this);
				Debug.Log ("Hit Target");
			}
		}

	}

	public void SetParentCar (CarController car)
	{
		parentCar = car;
	}

	void Shoot (Vector3 direction)
	{	
		m_direction = direction;
		m_shoot = true;
		gameManager = GameObject.FindGameObjectWithTag ("GameManager");
		if (gameManager == null)
			return;
		
		if (proType == ProjectileType.RED && gameManager.GetComponent<CheckpointManager> ().getNext (parentCar)) {
			targetCar = gameManager.GetComponent<CheckpointManager> ().getNext (parentCar).gameObject;
		} else if (proType == ProjectileType.BLUE) {
			targetCar = gameManager.GetComponent<CheckpointManager> ().getFirstCar ().gameObject;
		}
	}
}
