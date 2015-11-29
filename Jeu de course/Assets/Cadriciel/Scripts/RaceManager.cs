using UnityEngine;
using System.Collections.Generic;
using System.Collections;
using System.Text;

public class RaceManager : MonoBehaviour 
{


	[SerializeField]
	private GameObject _carContainer;

	[SerializeField]
	private GUIText _announcement;

	[SerializeField]
	private int _timeToStart;

	[SerializeField]
	private int _endCountdown;

	// Use this for initialization
	void Awake () 
	{
		CarActivation(false);

	}
	
	void Start()
	{
		StartCoroutine(StartCountdown());
	}

	IEnumerator StartCountdown()
	{
		int count = _timeToStart;
		do 
		{
			_announcement.text = count.ToString();
			yield return new WaitForSeconds(1.0f);
			count--;
		}
		while (count > 0);
		_announcement.text = "Partez!";
		CarActivation(true);
		yield return new WaitForSeconds(1.0f);
		_announcement.text = "";
	}

	public void EndRace(string winner)
	{
		StartCoroutine(EndRaceImpl(winner));
	}

	IEnumerator EndRaceImpl(string winner)
	{
		CarActivation(false);
		_announcement.fontSize = 20;
		int count = _endCountdown;
        string ranking = GetRanking();
		do 
		{
            _announcement.text = "Victoire: " + winner + " en premiere place. Retour au titre dans " + count.ToString() + "\n\n" + ranking;
			yield return new WaitForSeconds(1.0f);
			count--;
		}
		while (count > 0);

		Application.LoadLevel("boot");
	}

    string GetRanking()
    {
        List<KeyValuePair<CarController, CheckpointManager.PositionData>> carRanking = gameObject.GetComponent<CheckpointManager>().CarsRanking;
        StringBuilder ranking = new StringBuilder();
        ranking.Append("Classement : \n\n");
        int i = 1;
        foreach(KeyValuePair<CarController, CheckpointManager.PositionData> car in carRanking)
        {
            ranking.AppendFormat("{0}  -  {1}\n", i++, car.Key.name);
        }
        return ranking.ToString();
    }

	public void Announce(string announcement, float duration = 2.0f)
	{
		StartCoroutine(AnnounceImpl(announcement,duration));
	}

	IEnumerator AnnounceImpl(string announcement, float duration)
	{
		_announcement.text = announcement;
		yield return new WaitForSeconds(duration);
		_announcement.text = "";
	}

	public void CarActivation(bool activate)
	{
		foreach (CarAIControl car in _carContainer.GetComponentsInChildren<CarAIControl>(true))
		{
			car.enabled = activate;
		}
		
		foreach (CarUserControlMP car in _carContainer.GetComponentsInChildren<CarUserControlMP>(true))
		{
			car.enabled = activate;
		}

	}
}
