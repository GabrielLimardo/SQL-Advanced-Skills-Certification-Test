WITH MaxScores AS (
    SELECT 
        event_id,
        participant_name,
        MAX(score) AS max_score
    FROM scoretable
    GROUP BY event_id, participant_name
)

, RankedParticipants AS (
    SELECT 
        event_id,
        participant_name,
        DENSE_RANK() OVER (PARTITION BY event_id ORDER BY max_score DESC) AS dr
    FROM MaxScores
)

SELECT 
    event_id,
    GROUP_CONCAT(CASE WHEN dr = 1 THEN participant_name END ORDER BY participant_name ASC) AS `Rank 1`,
    GROUP_CONCAT(CASE WHEN dr = 2 THEN participant_name END ORDER BY participant_name ASC) AS `Rank 2`,
    GROUP_CONCAT(CASE WHEN dr = 3 THEN participant_name END ORDER BY participant_name ASC) AS `Rank 3`
FROM RankedParticipants
WHERE dr <= 3
GROUP BY event_id
ORDER BY event_id;