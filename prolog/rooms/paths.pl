/* Paths for room 1*/
path(room_1, s, room_10).

/* Paths for room 2*/
path(room_2, e, room_3).

/* Paths for room 3*/
path(room_3, n, room_4).
path(room_3, n, room_4S).
path(room_3, e, room_16).
path(room_3, w, room_2).

/* Paths for room 4 */
path(room_4, n, room_6).
path(room_4N, n, room_6).
path(room_4, s, room_3).
path(room_4S, s, room_3).
path(room_4, w, room_5).
path(room_4N, w, room_5).

/* Paths for room 5 */
path(room_5, e, room_4).
path(room_5, e, room_4N).

/* Paths for room 6 */
path(room_6, n, room_10).
path(room_6, e, room_7).
path(room_6, s, room_4).
path(room_6, s, room_4N).

/* Paths for room 7 */
path(room_7, s, room_8).
path(room_7, w, room_6).

/* Paths for room 8 */
path(room_8, n, room_7).

/* Path for room 10 */
path(room_10, n, room_1).
path(room_10, e, room_11).
path(room_10, s, room_6).

/* Path for room 11 */
path(room_11, n, room_12).
path(room_11, e, room_14).
path(room_11, s, room_13).
path(room_11, w, room_10).

/* Path for room 12 */
path(room_12, s, room_11).

/* Path for room 13 */
path(room_13, n, room_11).

/* Path for room 14 */
path(room_14, s, room_15).
path(room_14, w, room_11).

/* Path for room 15 */
path(room_15, n, room_14).
path(room_15, s, room_16).

/* Path for room 16 */
path(room_16, n, room_15).
path(room_16, w, room_3).