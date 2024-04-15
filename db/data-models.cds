namespace btp.spacefarers;

using {
    cuid,
    managed
} from '@sap/cds/common';

@assert.unique: {email: [email]}

entity GalacticSpacefarers : cuid, managed {
    name: String(255);
    email: String(255);
    department: Association to one Departments;
    position: Association to one Positions;
    originPlanet: String(255);
    spacesuitColor: String(255);
    stardustCollection: Integer;
    wormholeNavigationSkill: Integer @assert.range: [0,10];

}

entity Departments: cuid, managed {
    name: String(255);
    spacefarers: Association to many GalacticSpacefarers on spacefarers.department = $self;
    positions: Association to many Positions on positions.department = $self;
}

entity Positions: cuid, managed {
    name: String(255);
    department: Association to one Departments;
    spacefarers: Association to many GalacticSpacefarers on spacefarers.position = $self;
}