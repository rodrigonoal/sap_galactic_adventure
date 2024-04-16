using SpacefarerService as service from '../../srv/spacefarers-service';

annotate service.GalacticSpacefarers with @(UI: {
    FieldGroup #Default         : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Email',
                Value: email,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Origin Planet',
                Value: originPlanet,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Spacesuit Color',
                Value: spacesuitColor,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Stardust Collection',
                Value: stardustCollection,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Wormhole Navigation Skill',
                Value: wormholeNavigationSkill,
            },
            // {
            //     $Type: 'UI.DataField',
            //     Value: department.name,
            //     Label: 'Department'
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Value: position.name,
            //     Label: 'Position',
            // },

        ],
    },
    Facets                             : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'DefaultFacet',
        Label : 'General Information',
        Target: '@UI.FieldGroup#Default',
    }, ],
    HeaderInfo                         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Galactic Spacefarer',
        TypeNamePlural: 'Galactic Spacefarers'
    },
    SelectionFields                    : [
        department_id,
        position_id
    ],
    DataPoint #WormholeNavigationRating: {
        Value        : wormholeNavigationSkill,
        TargetValue  : 10,
        Visualization: #Rating
    },
    DataPoint #StardustCollectionBar   : {
        Value        : stardustCollection,
        TargetValue  : 255,
        Visualization: #Progress
    },
    LineItem                           : [
        {
            $Type            : 'UI.DataField',
            Value            : name,
            Label            : 'Name',
            ![@UI.Importance]: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: originPlanet,
            Label: 'Origin Planet',
        },
        {
            $Type: 'UI.DataField',
            Value: spacesuitColor,
            Label: 'Spacesuit Color',
        },
        {
            $Type            : 'UI.DataFieldForAnnotation',
            Label            : 'Wormhole Navigation Rating',
            Target           : '@UI.DataPoint#WormholeNavigationRating',
            ![@UI.Importance]: #High,
        },
        {
            $Type            : 'UI.DataFieldForAnnotation',
            Label            : 'Stardust Collection Bar',
            Target           : '@UI.DataPoint#StardustCollectionBar',
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataField',
            Value            : spacesuitColor,
            Label            : 'Spacesuit Color',
            ![@UI.Importance]: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: department.name,
            Label: 'Department',
        },
        {
            $Type: 'UI.DataField',
            Value: position.name,
            Label: 'Position',
        },
        {
            $Type: 'UI.DataField',
            Value: department_id,
            Label: 'Department ID',
        },
        {
            $Type: 'UI.DataField',
            Value: position_id,
            Label: 'Position ID',
        },
    ],
}

);

annotate service.GalacticSpacefarers with {
    department @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Departments',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: department_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
        ],
    }
};

annotate service.GalacticSpacefarers with {
    position @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Positions',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: position_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
        ],
    }
};

annotate SpacefarerService.GalacticSpacefarers with {
    name                    @title: 'Name';
    stardustCollection      @title: 'Stardust Collection';
    wormholeNavigationSkill @title: 'Wormhole Navigation Skill';
    originPlanet            @title: 'Origin Planet';
    spacesuitColor          @title: 'Spacesuit Color';
    email                   @title: 'Email';
}
